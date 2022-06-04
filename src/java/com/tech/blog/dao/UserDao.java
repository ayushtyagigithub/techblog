
package com.tech.blog.dao;
import com.tech.blog.entities.User;
import java.sql.*;
public class UserDao {
   private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
    boolean f=false;
   public boolean saveUser(User user)
   {
       try{
           String query="insert into user(name,email,password,gender,about) value(?,?,?,?,?)";
           PreparedStatement psmt=this.con.prepareStatement(query);
           psmt.setString(1, user.getName());
           psmt.setString(2, user.getEmail());
           psmt.setString(3, user.getPassword());
           psmt.setString(4, user.getGender());
           psmt.setString(5, user.getAbout());
           psmt.executeUpdate();
           f=true;
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       return f;
   }
   public User getUserEmailAndPassword(String email,String password)
   {
       User user=null;
       try
       {
           String query="Select * from user where email=? and password=?";
           PreparedStatement psmt=con.prepareStatement(query);
           psmt.setString(1, email);
           psmt.setString(2, password);
           ResultSet set=psmt.executeQuery();
           if(set.next())
           {
               user=new User();
               String name=set.getString("name");
               user.setName(name);
               user.setId(set.getInt("id"));
               user.setEmail(set.getString("email"));
               user.setAbout(set.getString("about"));
               user.setDatetime(set.getTimestamp("rdate"));
               user.setProfile(set.getString("profile"));
               user.setGender(set.getString("gender"));
               user.setPassword(set.getString("password"));
           }
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       return user;
   }
   public boolean updateUser(User user)
   {
       boolean f=false;
       try
       {
           String query="update user set name=? , email=? , password=? , about=? , profile=? where id=?";
           PreparedStatement psmt=con.prepareStatement(query);
           psmt.setString(1, user.getName());
           psmt.setString(2, user.getEmail());
           psmt.setString(3,user.getPassword());
           psmt.setString(4,user.getAbout());
           psmt.setString(5,user.getProfile());
           psmt.setInt(6,user.getId());
           psmt.executeUpdate();
           f=true;
       }
       catch(Exception e)
       {
           e.printStackTrace();
       }
       return f;
   }
}
