using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using negocioCS.caja;
using System.Drawing;
using System.Globalization;
using System.Threading;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using negocioCS.admisiones;
using negocioCS.alumno;
using negocioCS.director;
using negocioCS.finanzas;
using negocioCS;
using negocioCS.ExpedienteAlumnos;

public partial class Dormitorios_BusquedaAlumnoD : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMensaje.Text = "";
        if (!Page.IsPostBack)
        {
            string sOpcion = Request.QueryString["of"];

            if (sOpcion == "1")
                lblTitulo.Text = "Búsqueda - Datos Alumno";
            else if (sOpcion == "2")
                lblTitulo.Text = "Búsqueda - Actualizar Alumno";
            else if (sOpcion == "3")
                lblTitulo.Text = "Búsqueda - Estado de Cuenta por Periodo";
        }
    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        if (txtMatricula.Text != "" || txtNombres.Text != "")
        {
            busqueda();
        }
        else
        {
            lblMensaje.Text = "Ingrese al menos un critério de búsqueda.";
            lblLeyenda.Visible = false;
            gvAlumnos.DataSource = null;
            gvAlumnos.DataBind();
        }
    }

    private void busqueda()
    {
        negocioCS.alumno.Alumno alumno = new negocioCS.alumno.Alumno();
        DataSet ds = alumno.getDatosAlumno(txtMatricula.Text, txtNombres.Text, Session["campus"].ToString());

        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count == 1)
            {
                string matricula = ds.Tables[0].Rows[0]["alu1Matricula"].ToString();

                datosAlumno(matricula);
                LlenarTabla(matricula);
                LlenarArreglos(matricula);
                curveChart();
            }
            else
            {
                lblLeyenda.Visible = true;
                gvAlumnos.DataSource = ds.Tables[0];
                gvAlumnos.DataBind();
            }
        }
        else
        {
            lblMensaje.Text = "No se encontraron registros.";
            lblLeyenda.Visible = false;
            gvAlumnos.DataSource = null;
            gvAlumnos.DataBind();
        }
    }

    protected void gvAlumnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAlumnos.PageIndex = e.NewPageIndex;
        busqueda();
    }

    protected void gvAlumnos_SelectedIndexChanged(object sender, EventArgs e)
    {


        string matricula = gvAlumnos.SelectedRow.Cells[1].Text;

        datosAlumno(matricula);
        LlenarTabla(matricula);
        LlenarArreglos(matricula);
        curveChart();
    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        Response.Redirect("/ulv/iu/menu_portal_ulv.aspx");
    }




    #region DatosAlumno
    protected void datosAlumno(string matricula)
    {

        pnlBusquedaAlumno.Visible = false;
        pnlDatosAlumno.Visible = true;
        pnlExpedienteAlu.Visible = true;
        lblFechaNacimiento.Text = "";

        if (matricula != null)
        {

            DormitorioNeg Dormitorio = new DormitorioNeg(Session["campus"].ToString());
            DataTable dtCuartos = Dormitorio.getValidacionAlumno(matricula);
            DataTable dtAlumno = Dormitorio.getDatoAlumno(matricula);

            if (dtAlumno != null)
            {
                lblFechaNacimiento.Text = Convert.ToDateTime(dtAlumno.Rows[0]["FechaNacimiento"]).ToString("dd / MM / yyyy");
            }
            else
            {
                lblFechaNacimiento.Text = "SIN REGISTRO";
            }

            if (dtCuartos != null)
            {
                lblCuartoAsignado.Text = dtCuartos.Rows[0]["numCuarto"].ToString();
                lblDormitorioAsignado.Text = dtCuartos.Rows[0]["idDormitorio"].ToString();

            }
            else
            {
                lblCuartoAsignado.Text = "N/A";
                lblDormitorioAsignado.Text = "NO ASIGNADO";
            }
            //deshabilitarControles();
            CajaNeg cajaNeg = new CajaNeg();
            DataSet ds = new DataSet();

            ds = cajaNeg.getDatosAlumno(matricula, Session["campus"].ToString());
            if (ds != null)
            {
                string cicloEscolar = ds.Tables["DatosAlumno"].Rows[0]["alu1Curso"].ToString();
                DataTable dtTrabajo = Dormitorio.getDepTrabajo(matricula, cicloEscolar);

                if (dtTrabajo != null)
                {
                    lblDepartamentoTrabajo.Text = dtTrabajo.Rows[0]["DepDepartamento"].ToString();
                }
                else
                {
                    lblDepartamentoTrabajo.Text = "";
                }


                if (ds.Tables["DatosAlumno"].Rows[0]["alu1Matricula"] != DBNull.Value)
                {
                    lblMatricula.Text = ds.Tables["DatosAlumno"].Rows[0]["alu1Matricula"].ToString();
                }
                if (ds.Tables["DatosAlumno"].Rows[0]["Alumno"] != DBNull.Value)
                { lblAlumno.Text = ds.Tables["DatosAlumno"].Rows[0]["Alumno"].ToString(); }
                if (ds.Tables["DatosAlumno"].Rows[0]["LeNombreEscuela"] != DBNull.Value)
                { lblEscuela.Text = ds.Tables["DatosAlumno"].Rows[0]["LeNombreEscuela"].ToString(); }
                if (ds.Tables["DatosAlumno"].Rows[0]["pePeriodoEsc"] != DBNull.Value)
                { lblSemestre.Text = ds.Tables["DatosAlumno"].Rows[0]["pePeriodoEsc"].ToString(); }
                if (ds.Tables["DatosAlumno"].Rows[0]["LeNivelAcademico"] != DBNull.Value)
                { lblNivelAcademico.Text = ds.Tables["DatosAlumno"].Rows[0]["LeNivelAcademico"].ToString(); }
                if (ds.Tables["DatosAlumno"].Rows[0]["Campus"] != DBNull.Value)
                { lblCampus.Text = ds.Tables["DatosAlumno"].Rows[0]["Campus"].ToString(); }
                if (ds.Tables["DatosAlumno"].Rows[0]["alu1Residencia"] != DBNull.Value)
                { lblResidencia.Text = ds.Tables["DatosAlumno"].Rows[0]["alu1Residencia"].ToString(); }
                if (ds.Tables["DatosAlumno"].Rows[0]["alu1Acfe"] != DBNull.Value)
                {
                    if (ds.Tables["DatosAlumno"].Rows[0]["alu1Acfe"].ToString() == "True")
                    { lblACFE.Text = "SI"; }
                    else { lblACFE.Text = "NO"; }
                }
                if (ds.Tables["DatosAlumno"].Rows[0]["alu1Inscrito"] != DBNull.Value)
                { lblInscrito.Text = ds.Tables["DatosAlumno"].Rows[0]["alu1Inscrito"].ToString(); }

                if (ds.Tables["DatosAlumno"].Rows[0]["alu1TipoSolicitud"] != DBNull.Value)
                { lblSolicitud.Text = ds.Tables["DatosAlumno"].Rows[0]["alu1TipoSolicitud"].ToString(); }

                if (ds.Tables["DatosAlumno"].Rows[0]["alu1Clasificacion"] != DBNull.Value)
                { lblPlanClasificacion.Text = ds.Tables["DatosAlumno"].Rows[0]["alu1Clasificacion"].ToString(); }

                lblTipoCurso.Text = ds.Tables["DatosAlumno"].Rows[0]["LeTipoCurso"].ToString();

                if (CajaNeg.planTrabajo != null)
                {
                    lblPlanTrabajo.Text = CajaNeg.planTrabajo.ToString();
                }
                else
                {
                    if (lblResidencia.Text == "INTERNO")
                        lblPlanTrabajo.Text = "SERVICIO 2";
                }

                getImagen();
            }
            else
            {
                lblMensaje.Text = "No se encontro registro";
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + this.lblMensaje.Text + "');", true);
            }
        }
        else
        {
            Session["page_error"] = "La variable de sesión sMatriculaF está vacia.";
            Response.Redirect("/ulv/iu/page_error.aspx");
        }

    }

    private void getImagen()
    {
        negocioCS.controlEscolar.Kardex k = new negocioCS.controlEscolar.Kardex();
        DataSet ds = k.getFoto(lblMatricula.Text);
        if (ds != null)
        {
            try
            {
                byte[] imgArr = (byte[])ds.Tables[0].Rows[0]["foto"];
                System.IO.MemoryStream ms = new System.IO.MemoryStream(imgArr);
                imgImagen.ImageUrl = "data:image/jpg;base64," + Convert.ToBase64String(ms.ToArray(), 0, ms.ToArray().Length);
                imgImagen.Width = 150;
                imgImagen.Height = 150;
                ms.Close();
                ms.Dispose();
            }
            catch { }
        }
        else
        {
            imgImagen.ImageUrl = "../iu/images/mono.png";
            imgImagen.Width = 150;
            imgImagen.Height = 150;
        }
    }


    protected void btnNuevaBúsqueda_Click(object sender, EventArgs e)
    {
        pnlBusquedaAlumno.Visible = true;
        pnlDatosAlumno.Visible = false;
        pnlExpedienteAlu.Visible = false;
    }


    #endregion


    #region expediente

    //Vida Estudiantil
    protected void VidaUtil()
    {
        lblHorasAcumuladas.Text = "240";
        lblTotalHrs.Text = "380";
    }
     

    //Académico
    protected string curveChart()
    {
        
        ExpedienteAluNeg dtKardex = new ExpedienteAluNeg(Session["campus"].ToString());
        DataTable dtDatosKardex = dtKardex.getPromedioSemestre(lblMatricula.Text.ToString());

        string strDatos;
        strDatos = "[['Semestre', 'Promedio'],";


        if (dtDatosKardex != null)
        {
            foreach (DataRow dr in dtDatosKardex.Rows)
            {
                strDatos = strDatos + "[";
                strDatos = strDatos + "'" + dr[0] + "'" + "," + dr[2];
                strDatos = strDatos + "],";
            }


        }
        else
        {
            lblMensaje.Text = "";
        }


        strDatos = strDatos + "]";

        return strDatos;
    }

    protected void lbtnDetallePromedio_Click(object sender, EventArgs e)
    {

    }

    protected void LlenarTabla(string sMatricula)
    {
        DataTable dtDatosKardexSem = new DataTable();
        ExpedienteAluNeg dtKardex = new ExpedienteAluNeg(Session["campus"].ToString());
        dtDatosKardexSem = dtKardex.getPromedioSemestre(sMatricula);


        gvKardex.DataSource = dtDatosKardexSem;
        gvKardex.DataBind();




    }

    protected DataTable dtCalificacionesSemestre()
    {
      
        DataTable dt = new DataTable();

        dt.Columns.Add("caaGradoEscolar");
        dt.Columns.Add("PePeriodoEsc");
        dt.Columns.Add("promFinal");
        return dt;
    }
    protected DataTable getdtDatosCuartos()
    {

        DataTable dtDatosKardex = dtCalificacionesSemestre();

        foreach (GridViewRow rows in gvKardex.Rows)
        {
            DataRow rdt = dtDatosKardex.NewRow();
            rdt["caaGradoEscolar"] = rows.Cells[0].Text;
            rdt["PePeriodoEsc"] = rows.Cells[1].Text;
            rdt["promFinal"] = rows.Cells[2].Text;
            dtDatosKardex.Rows.Add(rdt);
        }

        return dtDatosKardex;
    }

    #endregion

    #region Finanzas
    protected DataTable dtPanelArreglos()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("matricula");
        dt.Columns.Add("nombre");
        dt.Columns.Add("motivo");
        dt.Columns.Add("estatus");
        dt.Columns.Add("observaciones");
        dt.Columns.Add("monto");
        dt.Columns.Add("escuela");
        dt.Columns.Add("fechaInicio");
        dt.Columns.Add("fechaFin");
        return dt;
    }
    protected DataTable getdtCuentas()
    {
        DataTable dtArreglos = dtPanelArreglos();

        foreach (GridViewRow rows in gvArreglos.Rows)
        {

            DataRow rdt = dtArreglos.NewRow();
            rdt["matricula"] = rows.Cells[1].Text;
            rdt["nombre"] = rows.Cells[2].Text;
            rdt["motivo"] = rows.Cells[3].Text;
            rdt["estatus"] = rows.Cells[4].Text;
            rdt["observaciones"] = rows.Cells[5].Text;
            rdt["monto"] = rows.Cells[6].Text;
            rdt["escuela"] = rows.Cells[7].Text;
            rdt["fechaInicio"] = rows.Cells[8].Text;
            rdt["fechaFin"] = rows.Cells[9].Text;
            dtArreglos.Rows.Add(rdt);

        }
        return dtArreglos;
    }
    protected void LlenarArreglos(string sMatricula)
    {
        DataTable dtArreglos = new DataTable();

        ExpedienteAluNeg arreglosNeg = new ExpedienteAluNeg(Session["campus"].ToString());
        dtArreglos = arreglosNeg.getHistorialArreglos(sMatricula);

        gvArreglos.DataSource = dtArreglos;
        gvArreglos.DataBind();

    }
    #endregion



}
