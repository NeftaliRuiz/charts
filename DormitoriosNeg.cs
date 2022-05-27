using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using utilADOULV;

namespace negocioCS
{
    public class DormitorioNeg
    {
        private ConexionFacturacion conexion;
        public DormitorioNeg(string scampus)
        {
            conexion = new ConexionFacturacion(scampus);

        }

        #region Configuración
        public string setAltaCuartos(string snumCuarto, string sObservaciones, string scantidadCamas, string sStatus, string sidDormitorio)
        {
            string sql = "", smensaje = "";
            sql += " insert into Dormitorios_Cuartos (numCuarto,observaciones,cantidadCamas,estatus,idDormitorio)";
            sql += " VALUES('" + snumCuarto + "', '" + sObservaciones + "', '" + scantidadCamas + "', '" + sStatus + "', '" + sidDormitorio + "') ";


            smensaje = conexion.sentenciaExecuteNonQuery(sql);

            return smensaje;
        }

        public DataTable getDatosCuartos(string sUsuario )
        {
            DataTable dtDatosCuarto = null;

            string sql = "";
            sql += " SELECT A.numCuarto, A.observaciones, A.cantidadCamas, CASE WHEN A.estatus = 1 THEN 'Activo' ELSE 'Inactivo' END AS status, A.idDormitorio";
            sql += " FROM Dormitorios_Cuartos A";
            sql += " INNER JOIN Dormitorios_Catalogo B ON A.idDormitorio=B.idDormitorio ";
            sql += " WHERE EmpMatricula = '" + sUsuario + "'";

            dtDatosCuarto = conexion.getBusqueda(sql);

            return dtDatosCuarto;
        }

        public string setUpdateCuarto(string sNumCuarto, string sObservaciones, string scantidadCamas, string sEstatus, string idDormitorio)
        {
            string sql = "", smensaje = "";
            sql += " update Dormitorios_Cuartos SET observaciones = '" + sObservaciones + "',cantidadCamas = '" + scantidadCamas + "', estatus = '" + sEstatus + "' ";
            sql += " WHERE numCuarto = '" + sNumCuarto + "' AND idDormitorio = '" + idDormitorio + "'";


            smensaje = conexion.sentenciaExecuteNonQuery(sql);

            return smensaje;
        }

        public DataTable getDormitorio(string sUsuario)
        {
            DataTable dtDatosDormitorio = null;

            string sql = "";
            sql += " SELECT idDormitorio FROM Dormitorios_Catalogo ";
            sql += " WHERE EmpMatricula = '" + sUsuario + "' ";


            dtDatosDormitorio = conexion.getBusqueda(sql);

            return dtDatosDormitorio;
        }

        public DataTable getCuarto(string sCuarto, string sDormitorio)
        {
            DataTable dtCuarto = null;

            string sql = "";
            sql += " SELECT numCuarto, observaciones, cantidadCamas, idDormitorio, idCuarto, estatus FROM Dormitorios_Cuartos ";
            sql += "WHERE numCUarto = '" + sCuarto + "' and  idDormitorio = '" + sDormitorio + "'";

            dtCuarto = conexion.getBusqueda(sql);

            return dtCuarto;
        }
        public DataTable getCantCuarto(string sDormitorio)
        {
            DataTable dtCantCuarto = null;

            string sql = "";
            sql += " SELECT COUNT(numCuarto) as TotalCuartos FROM Dormitorios_Cuartos";
            sql += " WHERE idDormitorio = '" + sDormitorio + "' ";

            dtCantCuarto = conexion.getBusqueda(sql);

            return dtCantCuarto;
        }
        #endregion

        #region Asignación
        public DataTable getCuartosDormitorio(string sUsuario)
        {
            DataTable dtCuartosDormi = null;

            string sql = "";
            sql += " SELECT A.numCuarto, CASE WHEN A.estatus = 1 THEN 'btn btn-primary' ELSE 'btn btn-warning' END AS status, A.idCuarto ,INICIO ='',FIN ='', B.nombreDormitorio, C.EmpSexo, A.idDormitorio  FROM Dormitorios_Cuartos A";
            sql += " INNER JOIN Dormitorios_Catalogo B ON A.idDormitorio=B.idDormitorio  INNER JOIN DatosGenralEmp C ON B.EmpMatricula = C.EmpMatricula";
            sql += " WHERE B.EmpMatricula = '" + sUsuario + "' ";

            dtCuartosDormi = conexion.getBusqueda(sql);

            return dtCuartosDormi;
        }

        public DataTable getCantidadCamas(string sDormitorio)
        {
            DataTable dtCuartosDormi = null;

            string sql = "";
            sql += " SELECT SUM(cantidadCamas) as capacidad FROM Dormitorios_Cuartos ";
            sql += " WHERE idDormitorio = '" + sDormitorio + "' ";

            dtCuartosDormi = conexion.getBusqueda(sql);

            return dtCuartosDormi;
        }
        public DataTable getHospedados(string sDormitorio)
        {
            DataTable dtCuartosDormi = null;

            string sql = "";
            sql += " SELECT COUNT(alu1Matricula) as hospedados FROM Dormitorios_DistribucionCuartos";
            sql += " WHERE idDormitorio = '" + sDormitorio + "' ";


            dtCuartosDormi = conexion.getBusqueda(sql);

            return dtCuartosDormi;
        }

        public DataTable getDetalleCuarto(string sCuarto)
        {
            DataTable dtDetalleCuarto = null;

            string sql = "";
            sql += " SELECT A.idDormitorio, A.cantidadCamas,A.numCuarto, C.alu1Nombres, C.alu1Apellidos, B.alu1Matricula FROM Dormitorios_Cuartos A ";
            sql += " INNER JOIN Dormitorios_DistribucionCuartos B ON A.idCuarto = B.idCuarto";
            sql += " INNER JOIN Alu1datospersonales C ON B.alu1Matricula=C.alu1Matricula";
            sql += " WHERE A.idCuarto = '" + sCuarto + "'";

            dtDetalleCuarto = conexion.getBusqueda(sql);

            return dtDetalleCuarto;
        }
      

        public DataTable getDatoAlumno(string sAlumno)
        {
            DataTable dtDatoAlumno = null;

            string sql = "";
            sql += "SELECT alu1Nombres, alu1Apellidos, alu1Ciudad, alu1Estado, alu1Residencia,alu1Inscrito,alu1Sexo, Convert(DATE, alu1FechaNac)[FechaNacimiento]  FROM Alu1datospersonales WHERE alu1Matricula = '" + sAlumno + "'";

            dtDatoAlumno = conexion.getBusqueda(sql);

            return dtDatoAlumno;
        }

        public string setAsignarCuarto(string snumCuarto, string sAlumno, string sIdDormitorio)
        {
            string sql = "", smensaje = "";
            sql += " insert into Dormitorios_DistribucionCuartos (alu1Matricula, idCuarto, idDormitorio)";
            sql += " VALUES('" + sAlumno + "', '" + snumCuarto + "','" + sIdDormitorio + "' ) ";


            smensaje = conexion.sentenciaExecuteNonQuery(sql);

            return smensaje;
        }

        public DataTable getValidacionAlumno(string sAlumno)
        {
            DataTable dtValidAlumno = null;

            string sql = "";
            sql += "SELECT A.alu1Matricula,A.idCuarto,B.numCuarto,A.idDormitorio,C.nombreDormitorio FROM Dormitorios_DistribucionCuartos A INNER JOIN Dormitorios_Cuartos B ON A.idCuarto = B.idCuarto INNER JOIN Dormitorios_Catalogo C   ON   A.idDormitorio = C.idDormitorio WHERE alu1Matricula = '" + sAlumno + "'";

            dtValidAlumno = conexion.getBusqueda(sql);

            return dtValidAlumno;
        }

        public string setEliminarAlumno(string sAlumno)
        {
            string sql = "", smensaje = "";
            sql += " DELETE FROM Dormitorios_DistribucionCuartos WHERE alu1Matricula ='" + sAlumno + "'";

            smensaje = conexion.sentenciaExecuteNonQuery(sql);

            return smensaje;
        }


        public DataTable getSumHospedados(string sIdCuarto)
        {
            //Hospedados por cuarto
            DataTable dtHospedados = null;

            string sql = "";
            sql += "SELECT COUNT(alu1Matricula) as ocupado, idCuarto FROM Dormitorios_DistribucionCuartos WHERE idCuarto = '" + sIdCuarto + "' GROUP BY idCuarto";

            dtHospedados = conexion.getBusqueda(sql);

            return dtHospedados;
        }

        #endregion

        #region DatosAlumno
        public DataTable getDepTrabajo(string matricula, string cicloEscolar)
        {
            //Hospedados por cuarto
            DataTable dtDepTrabajo = null;

            string sql = "";
            sql += "SELECT B.DepDepartamento FROM vidaUtil_AlumnoPorDepartamento A  INNER JOIN Departamentos B ON A.idDepartamento=B.idDepartamento ";
            sql += "WHERE alu1Matricula = '" + matricula + "' and cicloEscolar = '" + cicloEscolar + "' ";

            dtDepTrabajo = conexion.getBusqueda(sql);

            return dtDepTrabajo;
        }

        public DataTable getDatosAlumno(string matricula, string cicloEscolar)
        {
            //Hospedados por cuarto
            DataTable dtDepTrabajo = null;

            string sql = "";
            sql += "SELECT B.DepDepartamento FROM vidaUtil_AlumnoPorDepartamento A  INNER JOIN Departamentos B ON A.idDepartamento=B.idDepartamento ";
            sql += "WHERE alu1Matricula = '" + matricula + "' and cicloEscolar = '" + cicloEscolar + "' ";

            dtDepTrabajo = conexion.getBusqueda(sql);

            return dtDepTrabajo;
        }
        #endregion


        #region coordinadorDormitorios



        public DataTable getHospedadosDormitorios()
        {
            //Hospedados por cuarto
            DataTable dtHospedados = null;

            string sql = "";
            sql += " SELECT idDormitorio As Dormitorio, COUNT(alu1Matricula) as Hospedados FROM Dormitorios_DistribucionCuartos GROUP BY idDormitorio";
           

            dtHospedados = conexion.getBusqueda(sql);

            return dtHospedados;
        }

        public DataTable getDatosDormitorios(string sDormitorio)
        {
            //Hospedados por cuarto
            DataTable dtDatosDormitorio = null;

            string sql = "";
            sql += " SELECT C.numCuarto,CONCAT(A.alu1Nombres,' ',A.alu1Apellidos) AS nombre , B.idDormitorio FROM Alu1datospersonales A";
            sql += " INNER JOIN Dormitorios_DistribucionCuartos B ON A.alu1Matricula = B.alu1Matricula";
            sql += " INNER JOIN Dormitorios_Cuartos C ON B.idCuarto = C.idCuarto  WHERE B.idDormitorio ='" + sDormitorio + "'"; 

            dtDatosDormitorio = conexion.getBusqueda(sql);

            return dtDatosDormitorio;
        }

        public DataTable getDormitorios()
        {
            //Hospedados por cuarto
            DataTable dtDatosDormitorio = null;

            string sql = "";
            sql += " SELECT C.idDormitorio, C.nombreDormitorio, A.Capacidad ,COUNT(DISTINCT B.alu1Matricula)[Hospedados]";
            sql += " FROM (SELECT idDormitorio, SUM(cantidadCamas)[Capacidad]FROM Dormitorios_Cuartos A GROUP BY idDormitorio) A";
            sql += " RIGHT JOIN Dormitorios_DistribucionCuartos B ON A.idDormitorio = B.idDormitorio";
            sql += " RIGHT JOIN Dormitorios_Catalogo C ON A.idDormitorio = C.idDormitorio";
            sql += " GROUP BY C.idDormitorio, C.nombreDormitorio,A.Capacidad";

            dtDatosDormitorio = conexion.getBusqueda(sql);

            return dtDatosDormitorio;
        }

        public DataTable getCuartosDormitorios(string sDormitorio)
        {
            DataTable dtDatosCuarto = null;

            string sql = "";
            sql += " SELECT A.numCuarto, A.observaciones, A.cantidadCamas,D.Hospedados, CASE WHEN A.estatus = 1 THEN 'Activo' ELSE 'Inactivo' END AS status, A.idDormitorio, A.idCuarto, CONCAT(C.EmpNombreDocente,' ',C.EmpApellidos) AS empleado,nombreDormitorio";
            sql += " FROM Dormitorios_Cuartos A";
            sql += " INNER JOIN Dormitorios_Catalogo B ON A.idDormitorio=B.idDormitorio INNER JOIN DatosGenralEmp C ON B.EmpMatricula = C.EmpMatricula ";
            sql += " LEFT JOIN (SELECT COUNT(DISTINCT alu1Matricula)[Hospedados],idCuarto FROM Dormitorios_DistribucionCuartos WHERE idDormitorio = '" + sDormitorio + "' GROUP BY idCuarto) D ON A.idCuarto = D.idCuarto";
            sql += " WHERE A.idDormitorio = '" + sDormitorio + "'";

            dtDatosCuarto = conexion.getBusqueda(sql);

            return dtDatosCuarto;
        }

        public DataTable getSumGeneralCuarto()
        {
            DataTable dtDatosCuarto = null;

            string sql = "";
            sql += " SELECT COUNT(numCuarto)[Cuartos],SUM(cantidadCamas)[Capacidad], (SELECT COUNT(alu1Matricula) FROM Dormitorios_DistribucionCuartos)[Hospedados] FROM Dormitorios_Cuartos";
           

            dtDatosCuarto = conexion.getBusqueda(sql);

            return dtDatosCuarto;
        }
        public string setEliminarCuarto(string sCuarto)
        {
            string sql = "", smensaje = "";
            sql += " DELETE FROM Dormitorios_Cuartos WHERE idCuarto ='" + sCuarto + "'";

            smensaje = conexion.sentenciaExecuteNonQuery(sql);

            return smensaje;
        }




        #endregion

    }

}
