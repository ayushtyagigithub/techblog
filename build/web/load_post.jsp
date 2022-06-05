<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<div class="row">
    <%
        Thread.sleep(1000);
        PostDao dao = new PostDao(ConnectionProvider.getConnection());
        List<Post> list=null;
        int cId=Integer.parseInt(request.getParameter("cid"));
        if (cId==0)
        {
            list=dao.getAllPost();
        }else
        {
            list=dao.getPostByCatId(cId);
        }
        if(list.size()==0)
        {
            out.println("<h3 class='display-3 text-center'>No post in this category</h3>");
            return;
        }
        for (Post cc : list) {
    %>
    <div class="col-md-6 mt-2">
        <img class="card-img-top" src="blog_pics/<%=cc.getpPic() %>" alt="Card image cap">
        <div class="card">
            <div class="card-body">
                <b><%=cc.getpTitle()%></b>
                <p><%=cc.getpContent()%></p>
                <pre><%=cc.getpCode()%></pre>
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>