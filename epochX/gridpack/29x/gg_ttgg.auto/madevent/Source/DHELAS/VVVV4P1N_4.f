C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     Metric(1,3)*Metric(2,4) - Metric(1,2)*Metric(3,4)
C     
      SUBROUTINE VVVV4P1N_4(V1, V2, V3, COUP,V4)
      IMPLICIT NONE
      COMPLEX*16 CI
      PARAMETER (CI=(0D0,1D0))
      COMPLEX*16 COUP
      COMPLEX*16 TMP1
      COMPLEX*16 TMP3
      COMPLEX*16 V1(*)
      COMPLEX*16 V2(*)
      COMPLEX*16 V3(*)
      COMPLEX*16 V4(6)
      TMP1 = (V2(3)*V1(3)-V2(4)*V1(4)-V2(5)*V1(5)-V2(6)*V1(6))
      TMP3 = (V3(3)*V1(3)-V3(4)*V1(4)-V3(5)*V1(5)-V3(6)*V1(6))
      V4(3)= COUP*(-CI*(V2(3)*TMP3)+CI*(V3(3)*TMP1))
      V4(4)= COUP*(+CI*(V2(4)*TMP3)-CI*(V3(4)*TMP1))
      V4(5)= COUP*(+CI*(V2(5)*TMP3)-CI*(V3(5)*TMP1))
      V4(6)= COUP*(+CI*(V2(6)*TMP3)-CI*(V3(6)*TMP1))
      END


