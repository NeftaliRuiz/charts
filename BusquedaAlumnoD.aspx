<%@ Page Language="C#" MasterPageFile="~/iu/portal_ulv.master" AutoEventWireup="true" CodeFile="BusquedaAlumnoD.aspx.cs" Inherits="Dormitorios_BusquedaAlumnoD" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="chead" ContentPlaceHolderID="head" runat="Server">
    
    <style type="text/css">
        #fotoAlumno {
            float: right;
        }

        body {
            font-family: Arial;
            font-size: 10pt;
        }

        .modalBackground {
            background-color: Black;
            filter: alpha(opacity=40);
            opacity: 0.4;
        }

        .modalPopup_observaciones {
            background-color: #FFFFFF;
            width: 400px;
            border: 3px solid #000000;
        }

            .modalPopup_observaciones .header {
                background-color: #000000;
                height: 30px;
                color: White;
                line-height: 30px;
                text-align: center;
                font-weight: bold;
            }

            .modalPopup_observaciones .body {
                min-height: 50px;
                line-height: 30px;
                text-align: center;
                padding: 5px;
            }

            .modalPopup_observaciones .footer {
                padding: 3px;
            }

            .modalPopup_observaciones .button {
                height: 23px;
                color: White;
                line-height: 23px;
                text-align: center;
                font-weight: bold;
                cursor: pointer;
                background-color: #9F9F9F;
                border: 1px solid #5C5C5C;
            }

            .modalPopup_observaciones td {
                text-align: center;
            }

        .modalPopup_DetalleCuenta13402 {
            background-color: #FFFFFF;
            width: 700px;
            border: 3px solid #000000;
        }

            .modalPopup_DetalleCuenta13402 .header {
                background-color: #000000;
                height: 30px;
                color: White;
                line-height: 30px;
                text-align: center;
                font-weight: bold;
            }

            .modalPopup_DetalleCuenta13402 .body {
                min-height: 50px;
                line-height: 30px;
                text-align: center;
                padding: 5px;
            }

            .modalPopup_DetalleCuenta13402 .footer {
                padding: 3px;
            }

            .modalPopup_DetalleCuenta13402 .button {
                height: 23px;
                color: White;
                line-height: 23px;
                text-align: center;
                font-weight: bold;
                cursor: pointer;
                background-color: #9F9F9F;
                border: 1px solid #5C5C5C;
            }

            .modalPopup_DetalleCuenta13402 td {
                text-align: center;
            }
    </style>

    <style type="text/css">
        .scrolling-table-container {
            height: 400px;
            overflow-y: scroll;
            overflow-x: hidden;
        }
    </style>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable(<%=curveChart()%>);

            var options = {
                title: 'Promedios por Semestre',
                curveType: 'function',
                
                legend: { position: 'bottom' }
            };

            var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

            chart.draw(data, options);
        }
    </script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.0/sweetalert.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.0/sweetalert.min.css" rel="stylesheet" type="text/css" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div>
    </div>

    <asp:Panel ID="pnlBusquedaAlumno" runat="server">

        <div class="white-box">
            <div id="fuentecinta" align="center">
                <asp:Label ID="lblTitulo" runat="server" Text="Búsqueda Alumno" CssClass="col-sm-12 control-label"></asp:Label>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <asp:Label ID="lblMensaje" runat="server" CssClass="col-sm-12 control-label" ForeColor="Red" Font-Bold="True"></asp:Label>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-1">
                    <div class="form-group">
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label class="col-sm-12 control-label">MATRICULA: </label>
                        <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-1">
                    <div class="form-group">
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label class="col-sm-12 control-label">NOMBRES/APELLIDOS: </label>
                        <asp:TextBox ID="txtNombres" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group">
                        <label class="col-sm-12 control-label">_ </label>
                        <asp:Button ID="btnBuscar" runat="server" Text="BUSCAR" CssClass="btn btn-block btn-primary" OnClick="btnBuscar_Click" />
                    </div>
                </div>
                <div class="col-md-1">
                    <div class="form-group">
                        <label class="col-sm-12 control-label">_ </label>
                        <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-block btn-warning" Text="Cancelar" OnClick="btnCancelar_Click" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <asp:Label ID="lblLeyenda" runat="server" CssClass="col-sm-12 control-label" Visible="False">:::Resultado de la búsqueda:::</asp:Label>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-1">
                    <div class="form-group">
                    </div>
                </div>

                <div class="col-md-10">
                    <div class="table-responsive">
                        <asp:GridView ID="gvAlumnos" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="table color-bordered-table primary-bordered-table" GridLines="None"
                            OnPageIndexChanging="gvAlumnos_PageIndexChanging" OnSelectedIndexChanged="gvAlumnos_SelectedIndexChanged">
                            <Columns>
                                <asp:CommandField ButtonType="Image"
                                    SelectImageUrl="~/iu/images/seleccionar.jpg" ShowSelectButton="True" />
                                <asp:BoundField DataField="alu1Matricula" HeaderText="Matrícula" />
                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                <asp:BoundField DataField="alu1Inscrito" HeaderText="Inscrito" />
                                <asp:BoundField DataField="LeNombreEscuelaOficial" HeaderText="Escuela" />
                            </Columns>
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle CssClass="pagination-ys" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

    </asp:Panel>

    <asp:Panel runat="server" ID="pnlDatosAlumno" Visible="false">

        <div class="white-box">

            <div class="row">
                <div class="col-md-2">
                    <div class="form-group"></div>
                </div>
                <div class="col-md-8">
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" CssClass="controles" Text="" ForeColor="#33CC33" Font-Bold="true"></asp:Label>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group"></div>
                </div>
            </div>
            <%--TITULOS DE SECCIONES INICIO--%>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="panel panel-primary block6">
                            <div class="panel-heading">
                                <asp:Label ID="lblEtiDatosAlumno" runat="server" class="col-sm-12 control-label" align="center">DATOS DEL ALUMNO</asp:Label>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <%--PRIMER COLUMNA--%>
                <div class="col-md-8">
                    <%--PRIMER FILA--%>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblEtiMatricula" runat="server" class="col-sm-12 control-label">MATRICULA:</asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <asp:Label ID="lblMatricula" runat="server" class="form-control"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblDomirtorio" runat="server" class="col-sm-12 control-label">DORMITORIO:</asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <asp:Label ID="lblDormitorioAsignado" runat="server" class="form-control"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--SEGUNDA FILA--%>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="form-group">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblEtiAlumno" runat="server" class="col-sm-12 control-label">ALUMNO: </asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-9">
                                    <div class="form-group">
                                        <asp:Label ID="lblAlumno" runat="server" class="form-control"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblEtiACFE" runat="server" class="col-sm-12 control-label">ACFE:</asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <asp:Label ID="lblACFE" runat="server" class="form-control"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--TERCERA FILA--%>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="lblEtiEscuela" runat="server" class="col-sm-12 control-label">ESCUELA:</asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-10">
                                    <div class="form-group">
                                        <asp:Label ID="lblEscuela" runat="server" class="form-control"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--SEGUNDA COLUMNA--%>
                <div class="col-md-4">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Label ID="lblCuarto" runat="server" class="col-sm-12 control-label">No. CUARTO:</asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Label ID="lblCuartoAsignado" runat="server" class="form-control"></asp:Label>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Label ID="lblEtiInscrito" runat="server" class="col-sm-12 control-label">INSCRITO:</asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Label ID="lblInscrito" runat="server" class="form-control"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Label ID="lblEtiCampus" runat="server" class="col-sm-12 control-label">CAMPUS:</asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="lblCampus" runat="server" class="form-control"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div id="fotoAlumno">
                                    <asp:Image ID="imgImagen" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4">
                            <asp:Label ID="lblEtiNivelAcademico" runat="server" class="col-sm-12 control-label">NIVEL</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblNivelAcademico" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4">
                            <asp:Label ID="lblEtiSemestre" runat="server" class="col-sm-12 control-label">SEMESTRE:</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblSemestre" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4">
                            <asp:Label ID="lblEtiResidencia" runat="server" class="col-sm-12 control-label">RESIDENCIA:</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblResidencia" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <br />
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4">
                            <asp:Label ID="lblEtiTipoCurso" runat="server" class="col-sm-12 control-label">TIPO CURSO:</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblTipoCurso" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4">
                            <asp:Label ID="lblEtiSolicitud" runat="server" class="col-sm-12 control-label">SOLICITUD:</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblSolicitud" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4">
                            <asp:Label ID="lblEtiPlanClasicicacion" runat="server" class="col-sm-12 control-label">Plan/ Clasificación:</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblPlanClasificacion" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4">
                            <asp:Label ID="lblEtiPlanTrabajo" runat="server" class="col-sm-12 control-label">PLAN/TRABAJO:</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblPlanTrabajo" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <div class="col-md-3">
                            <asp:Label ID="lblDepTrabajo" runat="server" class="col-sm-12 control-label">ÁREA/TRABAJO:</asp:Label>
                        </div>
                        <div class="col-md-9">
                            <asp:Label ID="lblDepartamentoTrabajo" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group">
                        <div class="col-md-5">
                            <asp:Label ID="lblCumpleaños" runat="server" class="col-sm-12 control-label">FECHA NACIMIENTO:</asp:Label>
                        </div>
                        <div class="col-md-7">
                            <asp:Label ID="lblFechaNacimiento" runat="server" class="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-md-5">
                </div>
                <div class="col-md-2">
                    <asp:LinkButton ID="btnNuevaBúsqueda" runat="server" CssClass="btn btn-success" OnClick="btnNuevaBúsqueda_Click"> <i class="icon-arrow-left-circle"></i> Regresar </asp:LinkButton>
                </div>
                <div class="col-md-5">
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="pnlExpedienteAlu" Visible="false">

        <div class="row">
            <div class="col-lg-12 col-sm-12 col-xs-12">
                <div class="white-box">
                    <div class="panel panel-primary block6">
                        <div class="panel-heading">
                            <asp:Label ID="g" runat="server" class="col-sm-12 control-label" align="center">EXPEDIENTE DEL ALUMNO</asp:Label>
                        </div>
                    </div>
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#VE" aria-controls="home" role="tab" data-toggle="tab" aria-expanded="true"><span class="visible-xs"></span><span class="hidden-xs"><i class="fa fa-group"></i>Vida Estudiantil</span></a></li>
                        <li role="presentation" class=""><a href="#Academico" aria-controls="profile" role="tab" data-toggle="tab" aria-expanded="false"><span class="visible-xs"></span><span class="hidden-xs"><i class="fa fa-mortar-board"></i>Académico</span></a></li>
                        <li role="presentation" class=""><a href="#finanzas" aria-controls="messages" role="tab" data-toggle="tab" aria-expanded="false"><span class="visible-xs"></span><span class="hidden-xs"><i class="fa fa-dollar"></i>Finanzas</span></a></li>
                        <li role="presentation" class=""><a href="#medico" aria-controls="settings" role="tab" data-toggle="tab" aria-expanded="false"><span class="visible-xs"></span><span class="hidden-xs"><i class="fa fa-heart"></i>Médico</span></a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="VE">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="form-row">
                                        <div class="col-md-3">
                                            <div class="form-label-group">
                                                <div class="form-group">
                                                    <label for="lblTotalHrs">Total Horas</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon"><i class="ti-timer"></i></div>
                                                        <asp:Label ID="lblTotalHrs" runat="server" class="form-control" />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-label-group">
                                                <div class="form-group">
                                                    <label for="lblHorasAcumuladas">Horas Trabajadas</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon"><i class="ti-check"></i></div>
                                                        <asp:Label ID="lblHorasAcumuladas" runat="server" class="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="panel-heading">
                                    <h3 class="box-title">Comentarios</h3>
                                </div>
                                <div class="scrolling-table-container">
                                    <div class="col-md-12">
                                        <div class="comment-center">
                                            <div class="comment-body">
                                                <div class="user-img">
                                                    <img src="../plugins/images/users/pawandeep.jpg" alt="user" class="img-circle">
                                                </div>
                                                <div class="mail-contnet">
                                                    <h5>Pavan kumar</h5>
                                                    <span class="mail-desc">Donec ac condimentum massa. Etiam pellentesque pretium lacus. Phasellus ultricies dictum suscipit. Aenean commodo dui pellentesque molestie feugiat.</span> <span class="label label-rouded label-info">PENDING</span><a href="javacript:void(0)" class="action"><i class="ti-close text-danger"></i></a> <a href="javacript:void(0)" class="action"><i class="ti-check text-success"></i></a><span class="time pull-right">April 14, 2016</span>
                                                </div>
                                            </div>
                                            <div class="comment-body">
                                                <div class="user-img">
                                                    <img src="../plugins/images/users/sonu.jpg" alt="user" class="img-circle">
                                                </div>
                                                <div class="mail-contnet">
                                                    <h5>Sonu Nigam</h5>
                                                    <span class="mail-desc">Donec ac condimentum massa. Etiam pellentesque pretium lacus. Phasellus ultricies dictum suscipit. Aenean commodo dui pellentesque molestie feugiat.</span><span class="label label-rouded label-success">APPROVED</span><a href="javacript:void(0)" class="action"><i class="ti-close text-danger"></i></a> <a href="javacript:void(0)" class="action"><i class="ti-check text-success"></i></a><span class="time pull-right">April 14, 2016</span>
                                                </div>
                                            </div>
                                            <div class="comment-body">
                                                <div class="user-img">
                                                    <img src="../plugins/images/users/arijit.jpg" alt="user" class="img-circle">
                                                </div>
                                                <div class="mail-contnet">
                                                    <h5>Arijit Sinh</h5>
                                                    <span class="mail-desc">Donec ac condimentum massa. Etiam pellentesque pretium lacus. Phasellus ultricies dictum suscipit. Aenean commodo dui pellentesque molestie feugiat. </span><span class="label label-rouded label-danger">REJECTED</span><a href="javacript:void(0)" class="action"><i class="ti-close text-danger"></i></a> <a href="javacript:void(0)" class="action"><i class="ti-check text-success"></i></a><span class="time pull-right">April 14, 2016</span>
                                                </div>
                                            </div>
                                            <div class="comment-body b-none">
                                                <div class="user-img">
                                                    <img src="../plugins/images/users/pawandeep.jpg" alt="user" class="img-circle">
                                                </div>
                                                <div class="mail-contnet">
                                                    <h5>Pavan kumar</h5>
                                                    <span class="mail-desc">Donec ac condimentum massa. Etiam pellentesque pretium lacus. Phasellus ultricies dictum suscipit. Aenean commodo dui pellentesque molestie feugiat.</span> <span class="label label-rouded label-info">PENDING</span> <a href="javacript:void(0)" class="action"><i class="ti-close text-danger"></i></a><a href="javacript:void(0)" class="action"><i class="ti-check text-success"></i></a><span class="time pull-right">April 14, 2016</span>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                        </div>
                        <!--ACADÉMICO -->
                        <div role="tabPanel" class="tab-pane" id="Academico">
                            <div class="col-md-6"> 
                                <h3 class="box-title">Kardex</h3>
                                <asp:GridView ID="gvKardex" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" ClientIDMode="Static">
                                    <Columns>
                                        <asp:BoundField DataField="caaGradoEscolar" HeaderText="#" HtmlEncode="false" />
                                        <asp:BoundField DataField="PePeriodoEsc" HeaderText="SEMESTRE" HtmlEncode="false" />
                                        <asp:BoundField DataField="promFinal" HeaderText="PROMEDIO" HtmlEncode="false" />
                                        <%--<asp:TemplateField HeaderText="DETALLE">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnDetallePromedio" runat="server" CssClass="btn btn-circle btn-outline-primary" OnClick="lbtnDetallePromedio_Click">
                                                    <i class="icon-list"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                    </Columns>
                                </asp:GridView>
                                <!-- Fin Kardex-->

                                
                            </div>
                            <div class="col-md-6 pull-right">
                                <div id="curve_chart" ></div>

                            </div>
                            <div class="clearfix">

                            </div>
                        </div>
                        <!--FINANZAS -->
                        <div role="tabpanel" class="tab-pane" id="finanzas">
                            <div class="col-md-6">

                                <!--Historial Arreglos -->

                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading">Arreglos</div>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox ID="txtBuscar" ClientIDMode="Static" runat="server" placeholder="Buscar..." CssClass="form-control" onkeyup="Search_Gridview(this, 'gvArreglos')"></asp:TextBox>
                                            <br />
                                            <div class="scrolling-table-container">
                                                <asp:Panel ID="pnlArreglos" runat="server" ScrollBars="Auto">
                                                    <asp:GridView ID="gvArreglos" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" ClientIDMode="Static">
                                                        <Columns>
                                                            <asp:BoundField DataField="motivo" HeaderText="Motivo" HtmlEncode="false" />
                                                            <asp:BoundField DataField="estatus" HeaderText="Estatus" HtmlEncode="false" />
                                                            <asp:BoundField DataField="observaciones" HeaderText="Observaciones" HtmlEncode="false" />
                                                            <asp:BoundField DataField="monto" HeaderText="Monto" HtmlEncode="false" />
                                                            <asp:BoundField DataField="escuela" HeaderText="Escuela" HtmlEncode="false" Visible="false" />
                                                            <asp:BoundField DataField="fechaInicio" HeaderText="Fecha Inicio" HtmlEncode="false" Visible="true" />
                                                            <asp:BoundField DataField="fechaFin" HeaderText="Fin de Acuerdo" HtmlEncode="false" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-5 pull-right">
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <!--SALUD -->
                        <div role="tabpanel" class="tab-pane" id="medico">
                            <div class="col-md-6">

 
                            </div>
                            <div class="col-md-5 pull-right">
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>


