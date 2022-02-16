﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace buoi1_bai5
{
    class Program
    {
        static void Main(string[] args)
        {
            int n;
            Console.Write(" Nhap so luong hoc sinh: ");
            n = int.Parse(Console.ReadLine());
            Student[] _arrStudent = new Student[n];
            for (int i = 0; i < n; i++)
            {
                Console.WriteLine(" Nhap thong tin sinh vien thu: " + (i + 1).ToString());
                _arrStudent[i] = new Student();
                _arrStudent[i].nhap();
            }
            Console.WriteLine(" Danh sach hoc sinh: ");
            Console.WriteLine("{0,-30}{1,-15}{2,-15}{3,-15}", "Ho Ten", "Diem Toan", "Diem Van", "DTB");
            for (int i = 0; i < n; i++)
            {
                _arrStudent[i].xuat();
            }
            Console.ReadLine();
        }
    }
}
