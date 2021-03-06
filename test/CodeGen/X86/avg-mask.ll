; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefix=AVX512 --check-prefix=AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw -mattr=+avx512vl | FileCheck %s --check-prefix=AVX512 --check-prefix=AVX512BWVL

define <16 x i8> @avg_v16i8_mask(<16 x i8> %a, <16 x i8> %b, <16 x i8> %src, i16 %mask) nounwind {
; AVX512F-LABEL: avg_v16i8_mask:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpavgb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    kmovw %edi, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm1, %zmm1, %zmm1 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm1, %xmm1
; AVX512F-NEXT:    vpblendvb %xmm1, %xmm0, %xmm2, %xmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v16i8_mask:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgb %xmm1, %xmm0, %xmm2 {%k1}
; AVX512BWVL-NEXT:    vmovdqa %xmm2, %xmm0
; AVX512BWVL-NEXT:    retq
  %za = zext <16 x i8> %a to <16 x i16>
  %zb = zext <16 x i8> %b to <16 x i16>
  %add = add nuw nsw <16 x i16> %za, %zb
  %add1 = add nuw nsw <16 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %lshr = lshr <16 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %trunc = trunc <16 x i16> %lshr to <16 x i8>
  %mask1 = bitcast i16 %mask to <16 x i1>
  %res = select <16 x i1> %mask1, <16 x i8> %trunc, <16 x i8> %src
  ret <16 x i8> %res
}

define <16 x i8> @avg_v16i8_maskz(<16 x i8> %a, <16 x i8> %b, i16 %mask) nounwind {
; AVX512F-LABEL: avg_v16i8_maskz:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpavgb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    kmovw %edi, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm1, %zmm1, %zmm1 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm1, %xmm1
; AVX512F-NEXT:    vpand %xmm0, %xmm1, %xmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v16i8_maskz:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgb %xmm1, %xmm0, %xmm0 {%k1} {z}
; AVX512BWVL-NEXT:    retq
  %za = zext <16 x i8> %a to <16 x i16>
  %zb = zext <16 x i8> %b to <16 x i16>
  %add = add nuw nsw <16 x i16> %za, %zb
  %add1 = add nuw nsw <16 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %lshr = lshr <16 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %trunc = trunc <16 x i16> %lshr to <16 x i8>
  %mask1 = bitcast i16 %mask to <16 x i1>
  %res = select <16 x i1> %mask1, <16 x i8> %trunc, <16 x i8> zeroinitializer
  ret <16 x i8> %res
}

define <32 x i8> @avg_v32i8_mask(<32 x i8> %a, <32 x i8> %b, <32 x i8> %src, i32 %mask) nounwind {
; AVX512F-LABEL: avg_v32i8_mask:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    pushq %rbp
; AVX512F-NEXT:    movq %rsp, %rbp
; AVX512F-NEXT:    andq $-32, %rsp
; AVX512F-NEXT:    subq $32, %rsp
; AVX512F-NEXT:    movl %edi, (%rsp)
; AVX512F-NEXT:    vpavgb %ymm1, %ymm0, %ymm0
; AVX512F-NEXT:    kmovw (%rsp), %k1
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k2
; AVX512F-NEXT:    vpternlogd $255, %zmm1, %zmm1, %zmm1 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm1, %xmm1
; AVX512F-NEXT:    vpternlogd $255, %zmm3, %zmm3, %zmm3 {%k2} {z}
; AVX512F-NEXT:    vpmovdb %zmm3, %xmm3
; AVX512F-NEXT:    vinserti128 $1, %xmm3, %ymm1, %ymm1
; AVX512F-NEXT:    vpblendvb %ymm1, %ymm0, %ymm2, %ymm0
; AVX512F-NEXT:    movq %rbp, %rsp
; AVX512F-NEXT:    popq %rbp
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v32i8_mask:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgb %ymm1, %ymm0, %ymm2 {%k1}
; AVX512BWVL-NEXT:    vmovdqa %ymm2, %ymm0
; AVX512BWVL-NEXT:    retq
  %za = zext <32 x i8> %a to <32 x i16>
  %zb = zext <32 x i8> %b to <32 x i16>
  %add = add nuw nsw <32 x i16> %za, %zb
  %add1 = add nuw nsw <32 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %lshr = lshr <32 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %trunc = trunc <32 x i16> %lshr to <32 x i8>
  %mask1 = bitcast i32 %mask to <32 x i1>
  %res = select <32 x i1> %mask1, <32 x i8> %trunc, <32 x i8> %src
  ret <32 x i8> %res
}

define <32 x i8> @avg_v32i8_maskz(<32 x i8> %a, <32 x i8> %b, i32 %mask) nounwind {
; AVX512F-LABEL: avg_v32i8_maskz:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    pushq %rbp
; AVX512F-NEXT:    movq %rsp, %rbp
; AVX512F-NEXT:    andq $-32, %rsp
; AVX512F-NEXT:    subq $32, %rsp
; AVX512F-NEXT:    movl %edi, (%rsp)
; AVX512F-NEXT:    vpavgb %ymm1, %ymm0, %ymm0
; AVX512F-NEXT:    kmovw (%rsp), %k1
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k2
; AVX512F-NEXT:    vpternlogd $255, %zmm1, %zmm1, %zmm1 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm1, %xmm1
; AVX512F-NEXT:    vpternlogd $255, %zmm2, %zmm2, %zmm2 {%k2} {z}
; AVX512F-NEXT:    vpmovdb %zmm2, %xmm2
; AVX512F-NEXT:    vinserti128 $1, %xmm2, %ymm1, %ymm1
; AVX512F-NEXT:    vpand %ymm0, %ymm1, %ymm0
; AVX512F-NEXT:    movq %rbp, %rsp
; AVX512F-NEXT:    popq %rbp
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v32i8_maskz:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgb %ymm1, %ymm0, %ymm0 {%k1} {z}
; AVX512BWVL-NEXT:    retq
  %za = zext <32 x i8> %a to <32 x i16>
  %zb = zext <32 x i8> %b to <32 x i16>
  %add = add nuw nsw <32 x i16> %za, %zb
  %add1 = add nuw nsw <32 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %lshr = lshr <32 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %trunc = trunc <32 x i16> %lshr to <32 x i8>
  %mask1 = bitcast i32 %mask to <32 x i1>
  %res = select <32 x i1> %mask1, <32 x i8> %trunc, <32 x i8> zeroinitializer
  ret <32 x i8> %res
}

define <64 x i8> @avg_v64i8_mask(<64 x i8> %a, <64 x i8> %b, <64 x i8> %src, i64 %mask) nounwind {
; AVX512F-LABEL: avg_v64i8_mask:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    pushq %rbp
; AVX512F-NEXT:    movq %rsp, %rbp
; AVX512F-NEXT:    andq $-32, %rsp
; AVX512F-NEXT:    subq $64, %rsp
; AVX512F-NEXT:    movl %edi, (%rsp)
; AVX512F-NEXT:    shrq $32, %rdi
; AVX512F-NEXT:    movl %edi, {{[0-9]+}}(%rsp)
; AVX512F-NEXT:    vpavgb %ymm3, %ymm1, %ymm1
; AVX512F-NEXT:    vpavgb %ymm2, %ymm0, %ymm0
; AVX512F-NEXT:    kmovw (%rsp), %k1
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k2
; AVX512F-NEXT:    vpternlogd $255, %zmm2, %zmm2, %zmm2 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm2, %xmm2
; AVX512F-NEXT:    vpternlogd $255, %zmm3, %zmm3, %zmm3 {%k2} {z}
; AVX512F-NEXT:    vpmovdb %zmm3, %xmm3
; AVX512F-NEXT:    vinserti128 $1, %xmm3, %ymm2, %ymm2
; AVX512F-NEXT:    vpblendvb %ymm2, %ymm0, %ymm4, %ymm0
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k1
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k2
; AVX512F-NEXT:    vpternlogd $255, %zmm2, %zmm2, %zmm2 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm2, %xmm2
; AVX512F-NEXT:    vpternlogd $255, %zmm3, %zmm3, %zmm3 {%k2} {z}
; AVX512F-NEXT:    vpmovdb %zmm3, %xmm3
; AVX512F-NEXT:    vinserti128 $1, %xmm3, %ymm2, %ymm2
; AVX512F-NEXT:    vpblendvb %ymm2, %ymm1, %ymm5, %ymm1
; AVX512F-NEXT:    movq %rbp, %rsp
; AVX512F-NEXT:    popq %rbp
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v64i8_mask:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovq %rdi, %k1
; AVX512BWVL-NEXT:    vpavgb %zmm1, %zmm0, %zmm2 {%k1}
; AVX512BWVL-NEXT:    vmovdqa64 %zmm2, %zmm0
; AVX512BWVL-NEXT:    retq
  %za = zext <64 x i8> %a to <64 x i16>
  %zb = zext <64 x i8> %b to <64 x i16>
  %add = add nuw nsw <64 x i16> %za, %zb
  %add1 = add nuw nsw <64 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %lshr = lshr <64 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %trunc = trunc <64 x i16> %lshr to <64 x i8>
  %mask1 = bitcast i64 %mask to <64 x i1>
  %res = select <64 x i1> %mask1, <64 x i8> %trunc, <64 x i8> %src
  ret <64 x i8> %res
}

define <64 x i8> @avg_v64i8_maskz(<64 x i8> %a, <64 x i8> %b, i64 %mask) nounwind {
; AVX512F-LABEL: avg_v64i8_maskz:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    pushq %rbp
; AVX512F-NEXT:    movq %rsp, %rbp
; AVX512F-NEXT:    andq $-32, %rsp
; AVX512F-NEXT:    subq $64, %rsp
; AVX512F-NEXT:    movl %edi, (%rsp)
; AVX512F-NEXT:    shrq $32, %rdi
; AVX512F-NEXT:    movl %edi, {{[0-9]+}}(%rsp)
; AVX512F-NEXT:    vpavgb %ymm3, %ymm1, %ymm1
; AVX512F-NEXT:    vpavgb %ymm2, %ymm0, %ymm0
; AVX512F-NEXT:    kmovw (%rsp), %k1
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k2
; AVX512F-NEXT:    vpternlogd $255, %zmm2, %zmm2, %zmm2 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm2, %xmm2
; AVX512F-NEXT:    vpternlogd $255, %zmm3, %zmm3, %zmm3 {%k2} {z}
; AVX512F-NEXT:    vpmovdb %zmm3, %xmm3
; AVX512F-NEXT:    vinserti128 $1, %xmm3, %ymm2, %ymm2
; AVX512F-NEXT:    vpand %ymm0, %ymm2, %ymm0
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k1
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k2
; AVX512F-NEXT:    vpternlogd $255, %zmm2, %zmm2, %zmm2 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm2, %xmm2
; AVX512F-NEXT:    vpternlogd $255, %zmm3, %zmm3, %zmm3 {%k2} {z}
; AVX512F-NEXT:    vpmovdb %zmm3, %xmm3
; AVX512F-NEXT:    vinserti128 $1, %xmm3, %ymm2, %ymm2
; AVX512F-NEXT:    vpand %ymm1, %ymm2, %ymm1
; AVX512F-NEXT:    movq %rbp, %rsp
; AVX512F-NEXT:    popq %rbp
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v64i8_maskz:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovq %rdi, %k1
; AVX512BWVL-NEXT:    vpavgb %zmm1, %zmm0, %zmm0 {%k1} {z}
; AVX512BWVL-NEXT:    retq
  %za = zext <64 x i8> %a to <64 x i16>
  %zb = zext <64 x i8> %b to <64 x i16>
  %add = add nuw nsw <64 x i16> %za, %zb
  %add1 = add nuw nsw <64 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %lshr = lshr <64 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %trunc = trunc <64 x i16> %lshr to <64 x i8>
  %mask1 = bitcast i64 %mask to <64 x i1>
  %res = select <64 x i1> %mask1, <64 x i8> %trunc, <64 x i8> zeroinitializer
  ret <64 x i8> %res
}

define <8 x i16> @avg_v8i16_mask(<8 x i16> %a, <8 x i16> %b, <8 x i16> %src, i8 %mask) nounwind {
; AVX512F-LABEL: avg_v8i16_mask:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpavgw %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    kmovw %edi, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm1, %zmm1, %zmm1 {%k1} {z}
; AVX512F-NEXT:    vpmovdw %zmm1, %ymm1
; AVX512F-NEXT:    vpblendvb %xmm1, %xmm0, %xmm2, %xmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v8i16_mask:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgw %xmm1, %xmm0, %xmm2 {%k1}
; AVX512BWVL-NEXT:    vmovdqa %xmm2, %xmm0
; AVX512BWVL-NEXT:    retq
  %za = zext <8 x i16> %a to <8 x i32>
  %zb = zext <8 x i16> %b to <8 x i32>
  %add = add nuw nsw <8 x i32> %za, %zb
  %add1 = add nuw nsw <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %lshr = lshr <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %trunc = trunc <8 x i32> %lshr to <8 x i16>
  %mask1 = bitcast i8 %mask to <8 x i1>
  %res = select <8 x i1> %mask1, <8 x i16> %trunc, <8 x i16> %src
  ret <8 x i16> %res
}

define <8 x i16> @avg_v8i16_maskz(<8 x i16> %a, <8 x i16> %b, i8 %mask) nounwind {
; AVX512F-LABEL: avg_v8i16_maskz:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpavgw %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    kmovw %edi, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm1, %zmm1, %zmm1 {%k1} {z}
; AVX512F-NEXT:    vpmovdw %zmm1, %ymm1
; AVX512F-NEXT:    vpand %xmm0, %xmm1, %xmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v8i16_maskz:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgw %xmm1, %xmm0, %xmm0 {%k1} {z}
; AVX512BWVL-NEXT:    retq
  %za = zext <8 x i16> %a to <8 x i32>
  %zb = zext <8 x i16> %b to <8 x i32>
  %add = add nuw nsw <8 x i32> %za, %zb
  %add1 = add nuw nsw <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %lshr = lshr <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %trunc = trunc <8 x i32> %lshr to <8 x i16>
  %mask1 = bitcast i8 %mask to <8 x i1>
  %res = select <8 x i1> %mask1, <8 x i16> %trunc, <8 x i16> zeroinitializer
  ret <8 x i16> %res
}

define <16 x i16> @avg_v16i16_mask(<16 x i16> %a, <16 x i16> %b, <16 x i16> %src, i16 %mask) nounwind {
; AVX512F-LABEL: avg_v16i16_mask:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpavgw %ymm1, %ymm0, %ymm0
; AVX512F-NEXT:    kmovw %edi, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm1, %zmm1, %zmm1 {%k1} {z}
; AVX512F-NEXT:    vpmovdw %zmm1, %ymm1
; AVX512F-NEXT:    vpblendvb %ymm1, %ymm0, %ymm2, %ymm0
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v16i16_mask:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgw %ymm1, %ymm0, %ymm2 {%k1}
; AVX512BWVL-NEXT:    vmovdqa %ymm2, %ymm0
; AVX512BWVL-NEXT:    retq
  %za = zext <16 x i16> %a to <16 x i32>
  %zb = zext <16 x i16> %b to <16 x i32>
  %add = add nuw nsw <16 x i32> %za, %zb
  %add1 = add nuw nsw <16 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %lshr = lshr <16 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %trunc = trunc <16 x i32> %lshr to <16 x i16>
  %mask1 = bitcast i16 %mask to <16 x i1>
  %res = select <16 x i1> %mask1, <16 x i16> %trunc, <16 x i16> %src
  ret <16 x i16> %res
}

define <16 x i16> @avg_v16i16_maskz(<16 x i16> %a, <16 x i16> %b, i16 %mask) nounwind {
; AVX512F-LABEL: avg_v16i16_maskz:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpavgw %ymm1, %ymm0, %ymm0
; AVX512F-NEXT:    kmovw %edi, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm1, %zmm1, %zmm1 {%k1} {z}
; AVX512F-NEXT:    vpmovdw %zmm1, %ymm1
; AVX512F-NEXT:    vpand %ymm0, %ymm1, %ymm0
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v16i16_maskz:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgw %ymm1, %ymm0, %ymm0 {%k1} {z}
; AVX512BWVL-NEXT:    retq
  %za = zext <16 x i16> %a to <16 x i32>
  %zb = zext <16 x i16> %b to <16 x i32>
  %add = add nuw nsw <16 x i32> %za, %zb
  %add1 = add nuw nsw <16 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %lshr = lshr <16 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %trunc = trunc <16 x i32> %lshr to <16 x i16>
  %mask1 = bitcast i16 %mask to <16 x i1>
  %res = select <16 x i1> %mask1, <16 x i16> %trunc, <16 x i16> zeroinitializer
  ret <16 x i16> %res
}

define <32 x i16> @avg_v32i16_mask(<32 x i16> %a, <32 x i16> %b, <32 x i16> %src, i32 %mask) nounwind {
; AVX512F-LABEL: avg_v32i16_mask:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    pushq %rbp
; AVX512F-NEXT:    movq %rsp, %rbp
; AVX512F-NEXT:    andq $-32, %rsp
; AVX512F-NEXT:    subq $32, %rsp
; AVX512F-NEXT:    movl %edi, (%rsp)
; AVX512F-NEXT:    kmovw (%rsp), %k1
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k2
; AVX512F-NEXT:    vpternlogd $255, %zmm6, %zmm6, %zmm6 {%k2} {z}
; AVX512F-NEXT:    vpmovdb %zmm6, %xmm6
; AVX512F-NEXT:    vpternlogd $255, %zmm7, %zmm7, %zmm7 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm7, %xmm7
; AVX512F-NEXT:    vpavgw %ymm3, %ymm1, %ymm1
; AVX512F-NEXT:    vpavgw %ymm2, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovzxbw {{.*#+}} ymm2 = xmm7[0],zero,xmm7[1],zero,xmm7[2],zero,xmm7[3],zero,xmm7[4],zero,xmm7[5],zero,xmm7[6],zero,xmm7[7],zero,xmm7[8],zero,xmm7[9],zero,xmm7[10],zero,xmm7[11],zero,xmm7[12],zero,xmm7[13],zero,xmm7[14],zero,xmm7[15],zero
; AVX512F-NEXT:    vpsllw $15, %ymm2, %ymm2
; AVX512F-NEXT:    vpsraw $15, %ymm2, %ymm2
; AVX512F-NEXT:    vpblendvb %ymm2, %ymm0, %ymm4, %ymm0
; AVX512F-NEXT:    vpmovzxbw {{.*#+}} ymm2 = xmm6[0],zero,xmm6[1],zero,xmm6[2],zero,xmm6[3],zero,xmm6[4],zero,xmm6[5],zero,xmm6[6],zero,xmm6[7],zero,xmm6[8],zero,xmm6[9],zero,xmm6[10],zero,xmm6[11],zero,xmm6[12],zero,xmm6[13],zero,xmm6[14],zero,xmm6[15],zero
; AVX512F-NEXT:    vpsllw $15, %ymm2, %ymm2
; AVX512F-NEXT:    vpsraw $15, %ymm2, %ymm2
; AVX512F-NEXT:    vpblendvb %ymm2, %ymm1, %ymm5, %ymm1
; AVX512F-NEXT:    movq %rbp, %rsp
; AVX512F-NEXT:    popq %rbp
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v32i16_mask:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgw %zmm1, %zmm0, %zmm2 {%k1}
; AVX512BWVL-NEXT:    vmovdqa64 %zmm2, %zmm0
; AVX512BWVL-NEXT:    retq
  %za = zext <32 x i16> %a to <32 x i32>
  %zb = zext <32 x i16> %b to <32 x i32>
  %add = add nuw nsw <32 x i32> %za, %zb
  %add1 = add nuw nsw <32 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %lshr = lshr <32 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %trunc = trunc <32 x i32> %lshr to <32 x i16>
  %mask1 = bitcast i32 %mask to <32 x i1>
  %res = select <32 x i1> %mask1, <32 x i16> %trunc, <32 x i16> %src
  ret <32 x i16> %res
}

define <32 x i16> @avg_v32i16_maskz(<32 x i16> %a, <32 x i16> %b, i32 %mask) nounwind {
; AVX512F-LABEL: avg_v32i16_maskz:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    pushq %rbp
; AVX512F-NEXT:    movq %rsp, %rbp
; AVX512F-NEXT:    andq $-32, %rsp
; AVX512F-NEXT:    subq $32, %rsp
; AVX512F-NEXT:    movl %edi, (%rsp)
; AVX512F-NEXT:    kmovw (%rsp), %k1
; AVX512F-NEXT:    kmovw {{[0-9]+}}(%rsp), %k2
; AVX512F-NEXT:    vpternlogd $255, %zmm4, %zmm4, %zmm4 {%k2} {z}
; AVX512F-NEXT:    vpmovdb %zmm4, %xmm4
; AVX512F-NEXT:    vpternlogd $255, %zmm5, %zmm5, %zmm5 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm5, %xmm5
; AVX512F-NEXT:    vpavgw %ymm3, %ymm1, %ymm1
; AVX512F-NEXT:    vpavgw %ymm2, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovzxbw {{.*#+}} ymm2 = xmm5[0],zero,xmm5[1],zero,xmm5[2],zero,xmm5[3],zero,xmm5[4],zero,xmm5[5],zero,xmm5[6],zero,xmm5[7],zero,xmm5[8],zero,xmm5[9],zero,xmm5[10],zero,xmm5[11],zero,xmm5[12],zero,xmm5[13],zero,xmm5[14],zero,xmm5[15],zero
; AVX512F-NEXT:    vpsllw $15, %ymm2, %ymm2
; AVX512F-NEXT:    vpsraw $15, %ymm2, %ymm2
; AVX512F-NEXT:    vpand %ymm0, %ymm2, %ymm0
; AVX512F-NEXT:    vpmovzxbw {{.*#+}} ymm2 = xmm4[0],zero,xmm4[1],zero,xmm4[2],zero,xmm4[3],zero,xmm4[4],zero,xmm4[5],zero,xmm4[6],zero,xmm4[7],zero,xmm4[8],zero,xmm4[9],zero,xmm4[10],zero,xmm4[11],zero,xmm4[12],zero,xmm4[13],zero,xmm4[14],zero,xmm4[15],zero
; AVX512F-NEXT:    vpsllw $15, %ymm2, %ymm2
; AVX512F-NEXT:    vpsraw $15, %ymm2, %ymm2
; AVX512F-NEXT:    vpand %ymm1, %ymm2, %ymm1
; AVX512F-NEXT:    movq %rbp, %rsp
; AVX512F-NEXT:    popq %rbp
; AVX512F-NEXT:    retq
;
; AVX512BWVL-LABEL: avg_v32i16_maskz:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    kmovd %edi, %k1
; AVX512BWVL-NEXT:    vpavgw %zmm1, %zmm0, %zmm0 {%k1} {z}
; AVX512BWVL-NEXT:    retq
  %za = zext <32 x i16> %a to <32 x i32>
  %zb = zext <32 x i16> %b to <32 x i32>
  %add = add nuw nsw <32 x i32> %za, %zb
  %add1 = add nuw nsw <32 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %lshr = lshr <32 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %trunc = trunc <32 x i32> %lshr to <32 x i16>
  %mask1 = bitcast i32 %mask to <32 x i1>
  %res = select <32 x i1> %mask1, <32 x i16> %trunc, <32 x i16> zeroinitializer
  ret <32 x i16> %res
}
