﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Crud_MVC_Dapper.Models
{
    public class RequestModel
    {
        public int? Id { get; set; }
        public string Search { get; set; }
        public string OrderBy { get; set; }
        public bool IsDescending { get; set; }
    }
}