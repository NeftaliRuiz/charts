using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocioCS;

public partial class Dormitorios_DatosAlumnoDormitorio : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        LlenarTabla();



    }

    #region principal

    //Grafica ALUMNOS HOSPEDADOS POR DORMITORIOS
    protected string pieChart()
    {
        DormitorioNeg HsopedadosDormi = new DormitorioNeg(Session["campus"].ToString());
        DataTable datos = HsopedadosDormi.getHospedadosDormitorios();

        string strDatos;
        strDatos = "[['Dormitorio', 'Hospedados'],";


        if (datos != null)
        {
            foreach (DataRow dr in datos.Rows)
            {
                strDatos = strDatos + "[";
                strDatos = strDatos + "'" + dr[0] + "'" + "," + dr[1];
                strDatos = strDatos + "],";
            }


        }
        else
        {
            lblMensaje.Text = "Aún no existe datos para mostrar.";
        }


        strDatos = strDatos + "]";

        return strDatos;
    }

    protected void LlenarTabla()
    {
        DataTable dtDateDormi = new DataTable();
        DormitorioNeg dtDormi = new DormitorioNeg(Session["campus"].ToString());
        DataTable dtTotal = dtDormi.getSumGeneralCuarto();
        dtDateDormi = dtDormi.getDormitorios();

        if (dtDateDormi != null)
        {
            lblTotalCuartos.Text = dtTotal.Rows[0]["cuartos"].ToString();
            lblCapacidad.Text = dtTotal.Rows[0]["capacidad"].ToString();
            lblTotalHospedados.Text = dtTotal.Rows[0]["Hospedados"].ToString();
            gvDatosDormitorios.DataSource = dtDateDormi;
            gvDatosDormitorios.DataBind();
        }
        else
        {
            lblMensajeTabla.Text = "No hay registros para mostrar";
        }

    }

    protected DataTable dtDatosDormitorios()
    {

        DataTable dt = new DataTable();

        dt.Columns.Add("idDormitorio");
        dt.Columns.Add("nombreDormitorio");
        dt.Columns.Add("Capacidad");
        dt.Columns.Add("Hospedados");
        return dt;
    }
    protected DataTable getdtDatosDormitorios()
    {

        DataTable dtDatosDormi = dtDatosDormitorios();

        foreach (GridViewRow rows in gvDatosDormitorios.Rows)
        {
            DataRow rdt = dtDatosDormi.NewRow();
            rdt["idDormitorio"] = rows.Cells[0].Text;
            rdt["nombreDormitorio"] = rows.Cells[1].Text;
            rdt["Capacidad"] = rows.Cells[1].Text;
            rdt["Hospedados"] = rows.Cells[1].Text;
            dtDatosDormi.Rows.Add(rdt);
        }

        return dtDatosDormi;
    }


    protected void lbtnVerDormitorio_Click(object sender, EventArgs e)
    {
        using (GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent)
        {

            int indicefilasel = row.RowIndex;

            DataTable dtDatos = getdtDatosDormitorios();


            LlenarTablaDormitorio(dtDatos.Rows[indicefilasel]["idDormitorio"].ToString());



        }
    }
    #endregion

    #region DatosDormitorio
    protected void LlenarTablaDormitorio(string sDormitorio)
    {
        DataTable dtDateCuarto = new DataTable();
        DormitorioNeg dtCuartos = new DormitorioNeg(Session["campus"].ToString());
        dtDateCuarto = dtCuartos.getCuartosDormitorios(sDormitorio);

        if (dtDateCuarto != null)
        {

            rptDatosDormitorio.DataSource = dtDateCuarto;
            rptDatosDormitorio.DataBind();
            lblNomPreceptor.Text = dtDateCuarto.Rows[0]["empleado"].ToString();
            lblTituloDormi.Text = dtDateCuarto.Rows[0]["nombreDormitorio"].ToString();

            pnlDatosDormi.Visible = true;
            pnlChartGeneral.Visible = false;
            pnlDormitorios.Visible = false; 

        }
        else
        {
            this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Alerta!', 'Aún no existen registros', 'warning');", true);
        }
    }

    protected void rptItemCuarto(object source, RepeaterCommandEventArgs e)
    {

        string sNumCuarto = e.CommandArgument.ToString();

        if (e.CommandName == "idCuarto")
        {
            DetalleCuarto(sNumCuarto);
        }
        else
        {
            EliminarCuarto(sNumCuarto);
        }

        
    }

    protected void DetalleCuarto(string sNumCuarto)
    {

        DormitorioNeg detalleCuarto = new DormitorioNeg(Session["campus"].ToString());
        DataTable dt = new DataTable();
        dt = detalleCuarto.getDetalleCuarto(sNumCuarto);
        DataTable dtCamas = detalleCuarto.getSumHospedados(sNumCuarto);


        if (dt != null)
        {

            string ocupado = dtCamas.Rows[0]["ocupado"].ToString();


            rptDatosCuarto.Visible = true;
            lblCodigoDormitorio.Text = dt.Rows[0]["idDormitorio"].ToString();
            lblCapacidadCuarto.Text = dt.Rows[0]["cantidadCamas"].ToString();
            lblNumCuarto.Text = dt.Rows[0]["numCuarto"].ToString();

            int disponible = Int32.Parse(lblCapacidadCuarto.Text) - Int32.Parse(ocupado);

            lblDisponibleCuartos.Text = disponible.ToString();


            rptDatosCuarto.DataSource = dt;
            rptDatosCuarto.DataBind();


        }
        else
        {
            LimpiarDatosCuartos();
            this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Alerta!', 'El cuarto no tiene alumnos asignados.', 'warning');", true);
        }

        lblIdCuarto.Text = sNumCuarto;
    }

    protected void EliminarCuarto(string sCuarto)
    {
        DormitorioNeg ElimCuarto = new DormitorioNeg(Session["campus"].ToString());
        String dt = ElimCuarto.setEliminarCuarto(sCuarto);

        this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Realizado!', 'El cuarto se eliminó exitosamente.', 'success');", true);
    }


    public void LimpiarDatosCuartos ()
    {
        rptDatosCuarto.Visible = false;
        lblCodigoDormitorio.Text = "";
        lblCapacidadCuarto.Text = "";
        lblNumCuarto.Text = "";
        lblNumCuarto.Text = "";
        lblDisponibleCuartos.Text ="";

    }

    #endregion




    protected void btnRegresar_Click(object sender, EventArgs e)
    {
        pnlDatosDormi.Visible = false;
        pnlChartGeneral.Visible = true;
        pnlDormitorios.Visible = true;
        LimpiarDatosCuartos();
    }
}