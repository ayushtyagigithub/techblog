<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.CategoryDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%
    User u = (User) session.getAttribute("currentuser");
    if (u == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    </head>
    <body>
        <!<!-- navbar start -->


        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#"><span class="fa fa-bell-o"></span>LearnCode With InfoTech<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span>Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming</a>
                            <a class="dropdown-item" href="#">Project Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span>Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span>Add Post</a>
                    </li>
                </ul>
                <ul class="navbar-nav mr-right">

                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#exampleModal"><span class="fa fa-user-circle"></span><%=u.getName()%></a>
                    </li>

                    <li class="nav-item">
                        <a href="out" class="nav-link" ><span class="fa fa-user-plus"></span>Logout</a>
                    </li>

                </ul>

            </div>
        </nav>









        <!<!-- navbar end -->















        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>
        <div class="alert <%=m.getCssClass()%>" role="alert">
            <%=m.getContent()%>
        </div>
        <%
            }
            session.removeAttribute("msg");
        %>

        <!<!-- list start -->

        <main>
            <div class="container">
                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="list-group">
                            <a href="#" onclick="getPost(0,this)" class=" c-link list-group-item list-group-item-action active">All Post</a>
                            <%
                                CategoryDao dao = new CategoryDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list1 = dao.getCategory();
                                for (Category cc : list1) {
                            %>
                            <a href="#" onclick="getPost(<%=cc.getCid() %>,this)" class=" c-link list-group-item list-group-item-action "><%=cc.getName()%></a>
                            <%
                                }
                            %>

                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-3x fa-spin"></i>
                            <h3 class="mt-3">Loading..</h3>
                        </div>
                        <div class="container-fluid" id="post-container">


                        </div> 

                    </div>
                </div>







            </div>








        </main>








        <!<!-- list end -->


        <!<!-- modal start -->



        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header  primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Tech Blog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= u.getProfile()%>" class="image-fluid" style="border-radius: 250px;max-width: 150px;">
                            <h5 class="modal-title" id="exampleModalLabel" style="margin-top: 10px;"><%=u.getName()%></h5>

                            <!<!-- table start -->

                            <div id="profile-details">

                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">Id :</th>
                                            <td><%=u.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">E-mail :</th>
                                            <td><%=u.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%=u.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">About :</th>
                                            <td><%=u.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Registration Date :</th>
                                            <td><%= u.getDatetime().toString()%></td>

                                        </tr>
                                    </tbody>
                                </table>





                            </div>

                            <div id="profile-edit" style="display: none;">
                                <h3>Please Edit Carefully</h3>
                                <form action="edit" method="POST" enctype="multipart/form-data">

                                    <table class="table">
                                        <tr>
                                            <td>Id :</td>
                                            <td><%=u.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Email :</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%=u.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%=u.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%=u.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%=u.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td><textarea class="form-control" rows="3" name="user_about"><%=u.getAbout()%></textarea></td>
                                        </tr>
                                        <tr>
                                            <td>Select pic :</td>
                                            <td><input type="file" name="user_profile" class="form-control"></td>
                                        </tr>









                                    </table>

                                    <div>
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>










                                </form> 

                            </div>






                            <!<!-- table end -->
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>





        <!<!-- modal end -->

        <!<!-- post modal -->



        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the Post Detail</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="mohan" action="addpost" method="POST" enctype="multipart/form-data">

                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---Select Category---</option>
                                    <%
                                        CategoryDao obj = new CategoryDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = obj.getCategory();
                                        for (Category c : list) {

                                    %>
                                    <option value="<%=c.getCid()%>"><%=c.getName()%></option>
                                    <%
                                        }
                                    %>




                                </select>



                            </div>


                            <div class="form-group">
                                <input type="text" class="form-control" name="ptitle" placeholder="Enter Title">
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" name="pcontent" placeholder="Enter Content" style="height:200px;"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" name="pcode" placeholder="Enter code(if any)" style="height:200px;"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Select pic..</label>
                                <br>
                                <input type="file" name="ppic">
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>




                        </form>
                    </div>
                </div>
            </div>
        </div>












        <!<!-- post modal end -->

        <!<!-- jqyery cdn-->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>


        <!--javascript code-->

        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {

                let editStatus = false;
                $("#edit-profile-button").click(function () {
                    if (editStatus == false)
                    {
                        $("#profile-details").hide();
                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back");
                    } else
                    {
                        $("#profile-details").show();
                        $("#profile-edit").hide();
                        editStatus = false;
                        $(this).text("Edit");
                    }
                });

            });
        </script>



        <!<!-- ajax for add post -->



        <script>
            $(document).ready(function () {

                $("#mohan").on("submit", function (event) {
                    event.preventDefault();
                    let form = new FormData(this);
                    $.ajax({
                        url: "addpost",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.trim() == 'done')
                            {
                                swal("Good job!", "Saved Successfully", "success");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("oops!", "something went wrong!", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })


        </script>






        <!<!-- end ajax for add post -->




        <!<!-- script for load_post -->

        <script>
            function getPost(catId,temp)
            {
                
                $("#loader").show();
                $("#post-container").hide();
                $(".c-link").removeClass('active');
                $.ajax({
                    url: "load_post.jsp",
                    data:{cid:catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                       
                        $("#loader").hide();
                        $("#post-container").show();
                        $("#post-container").html(data);
                        $(temp).addClass('active');
                    }

                })
            }
            $(document).ready(function (e) {
                let allpostref=$(".c-link")[0];
                getPost(0,allpostref);
            })

        </script>



        <!<!-- script end for load_post -->

    </body>
</html>
