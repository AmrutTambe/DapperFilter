using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Crud_MVC_Dapper.Models
{
    public class Car
    {
        public int Id { get; set; }
        [Required]
        [MaxLength(50)]
        [Display(Name = "Name Of Car")]
        public string CarName { get; set; }
        [Required]
        [MinLength(4)]
        [MaxLength(50)]
        [Display(Name = "Model Of Car")]
        public string CarModel { get; set; }
        [Required]
        [Display(Name = "Company Of Car")]
        public string Company { get; set; }
        [Required]
        [MaxLength(50)]
        [Display(Name = "Price of Car")]
        public int Price { get; set; }
    }
}