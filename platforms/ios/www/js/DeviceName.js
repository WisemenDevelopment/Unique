var DeviceName = {
getPicture: function(success, failure){
    cordova.exec(success, failure, "DeviceName", "GetDevice", []);
},
//_Getkey: function(success, failure){
  //  cordova.exec(success, failure, "DeviceName", "Getkey", []);
//},
//_Setkey: function(success, failure){
//   // cordova.exec(success, failure, "DeviceName", "Setkey", []);
//}
};
module.exports = DeviceName;