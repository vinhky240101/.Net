﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace buoi1_bai1
{
    class findMax
    {
        //phuong thuc nhap 1 so
        public int NhapMotSo()
        {
            int so;
            so = Convert.ToInt32(Console.ReadLine());
            return so;
        }
        //phuong thuc tim so lon nhat
        public int TimMax(int so1, int so2, int so3)
        {
            int max;
            max = so1 > so2 ? so1 : so2;
            max = max > so3 ? max : so3;
            return max;
        }
    }
}
