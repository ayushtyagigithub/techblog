/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

/**
 *
 * @author AYUSH TYAGI
 */
public class Helper {
    
    public static boolean deleteFile(String path)
    {
        boolean f=false;
        try
        {
            File file=new File(path);
           f=file.delete();
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    public static boolean saveFile(InputStream ir,String path)
    {
        boolean f=false;
        try
        {
         byte [] b=new byte[ir.available()];
         ir.read(b);
         FileOutputStream out=new FileOutputStream(path);
         out.write(b);
         out.flush();
         f=true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
}
