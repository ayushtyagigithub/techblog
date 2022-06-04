
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
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
public class EditServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out=resp.getWriter();
        String email=req.getParameter("user_email");
        String name=req.getParameter("user_name");
        String password=req.getParameter("user_password");
        String about=req.getParameter("user_about");
        Part part=req.getPart("user_profile");
        String imagename=part.getSubmittedFileName();
        HttpSession s=req.getSession();
        User u=(User)s.getAttribute("currentuser");
        u.setEmail(email);
        u.setName(name);
        u.setPassword(password);
        u.setAbout(about);
        String oldname=u.getProfile();
        u.setProfile(imagename);
        UserDao dao=new UserDao(ConnectionProvider.getConnection());
        if(dao.updateUser(u))
        {
            //out.println("Data Update Successfully");
            String path=req.getRealPath("/")+"pics"+File.separator+u.getProfile();
            String pathold=req.getRealPath("/")+"pics"+File.separator+oldname;
            if(!oldname.equals("default.png"))
            {
                Helper.deleteFile(pathold);
            }
            if(Helper.saveFile(part.getInputStream(), path))
            {
                Message m=new Message("Update successfully","success","alert-success");
                s.setAttribute("msg",m);
            }
            else
            {
                Message m=new Message("Something went wrong !","fail","alert-danger");
                s.setAttribute("msg",m);
            }
            resp.sendRedirect("profile.jsp");
        }
        else
        {
            out.println("Error");
        }
        
        
    }
    
}
