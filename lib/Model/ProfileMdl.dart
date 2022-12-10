class ProfileModel {
  String fName;
 // String age;
//  String genderCd;
  String city;
  String stateCd;
  String stateNm;
 // String genderNm;
 // String education;
  String Email;
  String contactNo;
  String langCd;
  String language;
  String userCd;
  String imgPath;
  String bankNm;
  String acNm;
  String acNo;
  String iffcCd;
  String code;

  ProfileModel(
      {this.fName,
      // this.genderCd,
      // this.age,
      this.city,
      this.stateCd,
      this.stateNm,
      this.Email,
      this.contactNo,
      // this.education,
      // this.genderNm,
      this.langCd,
      this.language,
      this.userCd,
      this.imgPath,
      this.acNm,
      this.acNo,
      this.bankNm,
      this.iffcCd,
      this.code});

  factory ProfileModel.fromjson(Map<String, dynamic> json) {
    return ProfileModel(
      fName: json['fName'] as String,
      // age: json['age'] as String,
      // genderCd: json['genderCd'] as String,
      city: json['city'] as String,
      stateCd: json['stateCd'] as String,
      stateNm: json['stateNm'] as String,
      contactNo: json['mobNo'] as String,
      Email: json['Email'] as String,
    //  education: json['education'] as String,
      langCd: json['langCd'] as String,
      language: json['language'] as String,
      userCd: json['userCd'] as String,
      imgPath: json['imagePath'] as String,
      bankNm: json['bnkNm'] as String,
      acNm: json['acNm'] as String,
      acNo: json['acNo'] as String,
      iffcCd: json['iffcCd'] as String,
      code: json['Code'] as String,
    );
  }

  Map<String, dynamic> toJsonFeth() {
    return {
      "fName": fName,
      // "age": age,
      // "genderCd": genderCd,
      "city": city,
      "stateCd": stateCd,
      "stateNm": stateNm,
      "Email": Email,
      "mobNo": contactNo,
      "language": language,
      "langCd": langCd,
    //  "education": education,
      "userCd": userCd,
      "imgPath": imgPath,
      "bnkNm": bankNm,
      "acNm": acNm,
      "acNo": acNo,
      "iffcCd": iffcCd,
      "Code": code,
    };
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "fName": fName,
      // "age": age,
      // "genderCd": genderCd,
      "city": city,
      "langCd": langCd,
      "Email": Email,
      "mobNo": contactNo,
     // "education": education,
      "stateCd": stateCd,
      "imagePath": imgPath,
      "userCd": userCd,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "fName": fName,
      // "age": age,
      // "genderCd": genderCd,
      "city": city,
      "langCd": langCd,
      "Email": Email,
      "mobNo": contactNo,
      "stateCd": stateCd,
      "imagePath": imgPath,
     // "education": education,
      "userCd": userCd,
      "Code": code,
    };
  }

  Map<String, dynamic> toJsonBnkUpdate() {
    return {
      "userCd": userCd,
      "bnkNm": bankNm,
      "acNm": acNm,
      "acNo": acNo,
      "iffcCd": iffcCd,
    };
  }

  Map<String, dynamic> toJsonProFeth() {
    return {
      "userCd": userCd,
    };
  }
}
