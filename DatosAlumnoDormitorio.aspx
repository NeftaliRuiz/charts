<%@ Page Title="DatosAlumnoDormitorio" Language="C#" AutoEventWireup="true" MasterPageFile="~/iu/portal_ulv.master" CodeFile="DatosAlumnoDormitorio.aspx.cs" Inherits="Dormitorios_DatosAlumnoDormitorio" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="chead" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable(<%=pieChart()%>);

            var options = {
                title: 'ALUMNOS HOSPEDADOS POR DORMITORIOS',
                width: '100%',
                height: '500px'
            };
            var chart = new google.visualization.PieChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }


    </script>

    <style type="text/css">
        .scrolling-table-container {
            height: 400px;
            overflow-y: scroll;
            overflow-x: hidden;
        }

        #chart_wrap {
            position: relative;
            padding-bottom: 100%;
            height: 0;
            overflow: hidden;
        }

        #piechart {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 500px;
        }
    </style>
</asp:Content>

<asp:Content ID="ccph" ContentPlaceHolderID="cph" runat="Server">
    <!--Titulo de página-->
    <div class="row bg-title">
        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
            <h4 class="page-title" style="padding-left: 5%">Dormitorios</h4>
        </div>
        <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12">
        </div>
    </div>
    <!--Fin de Titulo de página -->
    <div class="container-fluid">

        <!--Tabla Dormitorio-->
        <div class="row">
            <asp:Panel ID="pnlDormitorios" runat="server" Visible="true">
                <div class="col-sm-6">
                    <div class="white-box">
                        <div class="panel panel-primary ">
                            <div class="panel-heading">
                                <asp:Label ID="lblDatosDormitorio" runat="server" CssClass="col-sm-12 control-label" Text="DATOS DORMITORIO"></asp:Label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group">
                                <div class="form-row">
                                    <div class="col-md-4">
                                        <div class="form-label-group">
                                            <asp:Label runat="server"><strong>TOTAL CUARTOS:</strong></asp:Label>
                                            <asp:Label ID="lblTotalCuartos" runat="server" CssClass="form-control" BackColor="#eeeeee"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-label-group">
                                            <asp:Label ID="Label3" runat="server"><strong>CAPACIDAD TOTAL:</strong></asp:Label>
                                            <asp:Label ID="lblCapacidad" runat="server" CssClass="form-control" BackColor="#eeeeee"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-label-group">
                                            <asp:Label ID="Label6" runat="server"> <strong>TOTAL HOSPEDADOS:</strong></asp:Label>
                                            <asp:Label ID="lblTotalHospedados" runat="server" CssClass="form-control" BackColor="#eeeeee"></asp:Label>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <br />
                        <asp:GridView ID="gvDatosDormitorios" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" ClientIDMode="Static">
                            <Columns>
                                <asp:BoundField DataField="idDormitorio" HeaderText="ID" HtmlEncode="false" />
                                <asp:BoundField DataField="nombreDormitorio" HeaderText="NOMBRE" HtmlEncode="false" />
                                <asp:BoundField DataField="Capacidad" HeaderText="CAPACIDAD" HtmlEncode="false" />
                                <asp:BoundField DataField="Hospedados" HeaderText="HOSPEDADOS" HtmlEncode="false" />
                                <asp:TemplateField HeaderText="VER">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtnVerDormitorio" runat="server" CssClass="btn btn-circle btn-outline-primary" OnClick="lbtnVerDormitorio_Click">
                                        <i class="icon-eye"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label ID="lblMensajeTabla" runat="server" />
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlChartGeneral" runat="server" Visible="true">
                <div class="col-sm-6">
                    <div class="white-box">
                        <!--<div class="panel panel-primary block6">
                            <div class="panel-heading">
                                <asp:Label runat="server" CssClass="col-sm-12 control-label" Text="ALUMNOS HOSPEDADOS POR DORMITORIOS"></asp:Label>
                            </div>
                        </div>-->
                        <asp:Label ID="lblMensaje" runat="server" />
                        <div id="chart_wrap">
                            <div id="piechart"></div>
                        </div>
                        <%--<asp:Label runat="server"><strong>Total Hospedados: </strong> </asp:Label>
                        <asp:Label ID="lblTotalHospedados" runat="server" />--%>
                    </div>
                </div>
            </asp:Panel>
        </div>
        <asp:Panel ID="pnlDatosDormi" runat="server" Visible="false">
            <div class="white-box">
                <div class="row">
                    <div class="panel panel-primary ">
                        <div class="panel-heading" style="align-content: center">
                            <asp:Label ID="lblTituloDormi" runat="server" CssClass="col-sm-12 control-label"> </asp:Label>
                        </div>
                    </div>
                    <br />
                </div>
                <div class="row">

                    <div class="col-sm-6">

                        <div class="form-label-group">
                            <asp:Label ID="lblPreceptor" runat="server"><strong>PRECEPTOR:</strong></asp:Label>
                            <asp:Label ID="lblNomPreceptor" runat="server" CssClass="form-control "></asp:Label>
                        </div>
                        <br />

                        <br />
                        <h3 class="box-title m-b-0">Listadod de Cuartos</h3>
                        
                        <div class="scrolling-table-container">

                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Observaciones</th>
                                            <th>Capacidad</th>
                                            <th>Hospedados</th>
                                            <th>Status</th>
                                            <th>Ver</th>
                                        </tr>  
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptDatosDormitorio" runat="server" ClientIDMode="Static" OnItemCommand="rptItemCuarto">
                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "numCuarto") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "observaciones") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "cantidadCamas") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Hospedados") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "status") %></td>
                                                    <td>
                                                        <asp:LinkButton ID="lbtnVerCuarto" CssClass="btn btn-success btn-circle" runat="server" CommandArgument='<%# Eval("idCuarto")%>' CommandName="idCuarto" ClientIDMode="Predictable">
                                                            <i class="fa fa-eye"></i>
                                                        </asp:LinkButton>
                                                         <asp:LinkButton ID="lbtnEliminarCuarto" CssClass="btn btn-danger btn-circle" runat="server"  CommandArgument='<%# Eval("idCuarto")%>' CommandName="idCuartoE" ClientIDMode="Predictable">
                                                            <i class="fa fa-trash"></i>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>




                    <div class="col-lg-6 col-sm-6 col-xs-12">

                        <h3 class="box-title m-b-0">DATOS DEL CUARTO</h3>
                        <br />
                        <div class="row">
                            <div class="form-group">
                                <div class="form-row">
                                    <div class="col-md-3">
                                        <div class="form-label-group">
                                            <asp:Label ID="lblDormitorio" runat="server"><strong>DORMITORIO:</strong></asp:Label>
                                            <asp:Label ID="lblCodigoDormitorio" runat="server" CssClass="form-control" BackColor="#eeeeee"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-label-group">
                                            <asp:Label ID="lblNumCuartos" runat="server"><strong>N° CUARTO:</strong></asp:Label>
                                            <asp:Label ID="lblNumCuarto" runat="server" CssClass="form-control" BackColor="#eeeeee"></asp:Label>
                                            <asp:Label ID="lblIdCuarto" runat="server" CssClass="form-control" Visible="false"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-label-group">
                                            <asp:Label ID="lblCapacidadCuartos" runat="server"> <strong>CAPACIDAD:</strong></asp:Label>
                                            <asp:Label ID="lblCapacidadCuarto" runat="server" CssClass="form-control" BackColor="#eeeeee"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-label-group">
                                            <asp:Label ID="lblDisponible" runat="server"> <strong>DISPONIBLE:</strong></asp:Label>
                                            <asp:Label ID="lblDisponibleCuartos" runat="server" CssClass="form-control" BackColor="#eeeeee"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h2><small>Hospedados</small></h2>
                        <div class="table-responsive">
                            <table class="table color-bordered-table primary-bordered-table">
                                <thead>
                                    <tr>
                                        <th>Matrícula</th>
                                        <th>Nombre</th>
                                        <th>Apellidos</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptDatosCuarto" runat="server" ClientIDMode="Static">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# DataBinder.Eval(Container.DataItem, "alu1Matricula") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "alu1Nombres") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "alu1Apellidos") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>


                    </div>

                </div>

                <br />
                <br />
                <div class="row">
                    <div class="col-md-11">
                    </div>
                    <div class="col-md-1">
                        <asp:LinkButton ID="btnRegresar" runat="server" CssClass="btn btn-success" OnClick="btnRegresar_Click"> <i class="icon-arrow-left-circle"></i> Regresar </asp:LinkButton>
                    </div>
                    
                </div>

            </div>

        </asp:Panel>
    </div>

</asp:Content>



