diff --git a/epochX/cudacpp/gg_tt.mad/SubProcesses/P1_gg_ttx/auto_dsig1.f b/epochX/cudacpp/gg_tt.mad/SubProcesses/P1_gg_ttx/auto_dsig1.f
index 3aa1040b..edfabce3 100644
--- a/epochX/cudacpp/gg_tt.mad/SubProcesses/P1_gg_ttx/auto_dsig1.f
+++ b/epochX/cudacpp/gg_tt.mad/SubProcesses/P1_gg_ttx/auto_dsig1.f
@@ -454,22 +454,67 @@ C
       DOUBLE PRECISION JAMP2_MULTI(0:MAXFLOW, NB_PAGE)
 
       INTEGER IVEC
+      INTEGER IEXT
 
+#ifdef MG5AMC_MEEXPORTER_CUDACPP
+      INCLUDE 'coupl.inc'
+      INCLUDE 'fbridge.inc'
+      INCLUDE 'fbridge_common.inc'
+      DOUBLE PRECISION OUT2(NB_PAGE)
+      DOUBLE PRECISION CBYF1
+
+      INTEGER*4 NWARNINGS
+      SAVE NWARNINGS
+      DATA NWARNINGS/0/
+      
+      IF( FBRIDGE_MODE .LE. 0 ) THEN ! (FortranOnly=0 or BothQuiet=-1 or BothDebug=-2)
+#endif
+        call counters_smatrix1multi_start( -1, nb_page ) ! fortran=-1
+c!$OMP PARALLEL
+c!$OMP DO
+        DO IVEC=1, NB_PAGE
+          CALL SMATRIX1(P_MULTI(0,1,IVEC),
+     &      hel_rand(IVEC),
+     &      channel,
+     &      out(IVEC),
+C    &      selected_hel(IVEC),
+     &      jamp2_multi(0,IVEC),
+     &      IVEC
+     &      )
+        ENDDO
+c!$OMP END DO
+c!$OMP END PARALLEL
+        call counters_smatrix1multi_stop( -1 ) ! fortran=-1
+#ifdef MG5AMC_MEEXPORTER_CUDACPP
+      ENDIF
+
+      IF( FBRIDGE_MODE .EQ. 1 .OR. FBRIDGE_MODE .LT. 0 ) THEN ! (CppOnly=1 or BothQuiet=-1 or BothDebug=-2)
+        call counters_smatrix1multi_start( 0, nb_page ) ! cudacpp=0
+        CALL FBRIDGESEQUENCE(FBRIDGE_PBRIDGE, P_MULTI, ALL_G, OUT2)
+        call counters_smatrix1multi_stop( 0 ) ! cudacpp=0
+      ENDIF
+
+      IF( FBRIDGE_MODE .LE. -1 ) THEN ! (BothQuiet=-1 or BothDebug=-2)
+        DO IVEC=1, NB_PAGE
+          CBYF1 = OUT2(IVEC)/OUT(IVEC) - 1
+          FBRIDGE_NCBYF1 = FBRIDGE_NCBYF1 + 1
+          FBRIDGE_CBYF1SUM = FBRIDGE_CBYF1SUM + CBYF1
+          FBRIDGE_CBYF1SUM2 = FBRIDGE_CBYF1SUM2 + CBYF1 * CBYF1
+          IF( CBYF1 .GT. FBRIDGE_CBYF1MAX ) FBRIDGE_CBYF1MAX = CBYF1
+          IF( CBYF1 .LT. FBRIDGE_CBYF1MIN ) FBRIDGE_CBYF1MIN = CBYF1
+          IF( FBRIDGE_MODE .EQ. -2 ) THEN ! (BothDebug=-2)
+            WRITE (*,*) IVEC, OUT(IVEC), OUT2(IVEC), 1+CBYF1
+          ENDIF
+          IF( ABS(CBYF1).GT.5E-5 .AND. NWARNINGS.LT.20 ) THEN
+            NWARNINGS = NWARNINGS + 1
+            WRITE (*,'(A,I2,A,I4,4E16.8)')
+     &        'WARNING! (', NWARNINGS, '/20) Deviation more than 5E-5',
+     &        IVEC, OUT(IVEC), OUT2(IVEC), 1+CBYF1, ABS(CBYF1)
+          ENDIF
+        END DO
+      ENDIF
+#endif
 
-!$OMP PARALLEL
-!$OMP DO
-      DO IVEC=1, NB_PAGE
-        CALL SMATRIX1(P_MULTI(0,1,IVEC),
-     &	                         hel_rand(IVEC),
-     &				 channel,
-     &				 out(IVEC),
-C       &				 selected_hel(IVEC),
-     &				 jamp2_multi(0,IVEC),
-     &				 IVEC
-     &				 )
-      ENDDO
-!$OMP END DO
-!$OMP END PARALLEL
       RETURN
       END
 
