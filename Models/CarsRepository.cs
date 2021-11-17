using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Dapper;

namespace Crud_MVC_Dapper.Models
{
    public class CarsRepository
    {
        private string connectionstring;

        public CarsRepository()
        {
            connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["connectionstring"].ConnectionString;
        }

        public List<Car> GetAll(RequestModel request)
        {
            using (IDbConnection db = new SqlConnection(connectionstring))
            {
                return db
                    .Query<Car>("GetCars",
                    request,
                    commandType: CommandType.StoredProcedure)
                    .ToList();
            }
        }
        public Car Get(int Id)
        {
            using (IDbConnection db = new SqlConnection(connectionstring))
            {
                return db
                        .Query<Car>("GetCars",
                            new { Id },
                            commandType: CommandType.StoredProcedure)
                        .FirstOrDefault();
            }
        }
        public int Create(Car car)
        {
            using (IDbConnection db = new SqlConnection(connectionstring))
            {
                int lastInsertedId =
                    db.Query<int>("AddNewCarDetails",
                    car,
                    commandType: CommandType.StoredProcedure)
                    .FirstOrDefault();
                return lastInsertedId;
            }
        }
        public int Update(Car car)
        {
            using (IDbConnection db = new SqlConnection(connectionstring))
            {
                return db
                    .Execute("UpdateCarDetails",
                       car,
                       commandType: CommandType.StoredProcedure);
            }
        }
        public int Delete(int Id)
        {
            using (IDbConnection db = new SqlConnection(connectionstring))
            {
                return db.Execute(
                        "DeleteCarById",
                        new { Id },
                        commandType: CommandType.StoredProcedure);
            }
        }

        internal object Update(RequestModel request)
        {
            throw new NotImplementedException();
        }
    }
}
    
