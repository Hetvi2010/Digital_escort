class LoginData {
  static final Map<String, dynamic> mp={};
  /*@description:this is student's roll no*/
  static late String rollNo;
  static late String userName;
  static late String password;
  // static late String studentName='hetvi';
  static late String relation;
  static late String email;
  static late String cNumber;

  static void updateData({
    String rNo = '',
    String uName = '',
    String pword = '',
    String rel = '',
    String mail = '',
    String cnum = '',
  }) {
    rollNo = rNo;
    userName = uName;
    password = pword;
    relation = rel;
    email = mail;
    cNumber = cnum;
  }
}
