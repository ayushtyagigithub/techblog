
package com.tech.blog.servlets;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
@MultipartConfig
public class AddPost extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out=resp.getWriter();
        int cid=Integer.parseInt(req.getParameter("cid"));
        String title=req.getParameter("ptitle");
        String content=req.getParameter("pcontent");
        String code=req.getParameter("pcode");
        Part part=req.getPart("ppic");
        String pname=part.getSubmittedFileName();
        HttpSession s=req.getSession();
        User u=(User)s.getAttribute("currentuser");
        Post p=new Post(title,content,code,pname,null,cid,u.getId());
        PostDao dao=new PostDao(ConnectionProvider.getConnection());
        if(dao.savePost(p))
        {
            String path=req.getRealPath("/")+"blog_pics"+File.separator+pname;
            Helper.saveFile(part.getInputStream(), path);
            out.println("done");
            
            
        }
    }
    
}
