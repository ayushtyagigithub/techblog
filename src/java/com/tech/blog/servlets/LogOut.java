
package com.tech.blog.servlets;

import com.tech.blog.entities.Message;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogOut extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s=req.getSession();
        s.removeAttribute("currentuser");
        Message m=new Message("Logout Successfully !","success","alert-success");
        s.setAttribute("msg", m);
        resp.sendRedirect("login_page.jsp");
    }
    
}
