; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+mmx,+sse2 | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+mmx,+sse2 | FileCheck %s --check-prefix=X64

; FIXME: If we are transferring XMM conversion results to MMX registers we could use the MMX equivalents
; (CVTPD2PI/CVTTPD2PI + CVTPS2PI/CVTTPS2PI) with affecting rounding/expections etc.

define void @cvt_v2f64_v2i32(<2 x double>, <1 x i64>*) nounwind {
; X86-LABEL: cvt_v2f64_v2i32:
; X86:       # BB#0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $16, %esp
; X86-NEXT:    movl 8(%ebp), %eax
; X86-NEXT:    cvtpd2dq %xmm0, %xmm0
; X86-NEXT:    movd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; X86-NEXT:    movd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddd %mm0, %mm0
; X86-NEXT:    movq %mm0, (%esp)
; X86-NEXT:    movl (%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: cvt_v2f64_v2i32:
; X64:       # BB#0:
; X64-NEXT:    cvtpd2dq %xmm0, %xmm0
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    paddd %mm0, %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    retq
  %3 = tail call <4 x i32> @llvm.x86.sse2.cvtpd2dq(<2 x double> %0)
  %4 = bitcast <4 x i32> %3 to <2 x i64>
  %5 = extractelement <2 x i64> %4, i32 0
  %6 = bitcast i64 %5 to x86_mmx
  %7 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %6, x86_mmx %6)
  %8 = bitcast x86_mmx %7 to i64
  %9 = insertelement <1 x i64> undef, i64 %8, i32 0
  store <1 x i64> %9, <1 x i64>* %1
  ret void
}

define void @cvtt_v2f64_v2i32(<2 x double>, <1 x i64>*) nounwind {
; X86-LABEL: cvtt_v2f64_v2i32:
; X86:       # BB#0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $16, %esp
; X86-NEXT:    movl 8(%ebp), %eax
; X86-NEXT:    cvttpd2dq %xmm0, %xmm0
; X86-NEXT:    movss %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; X86-NEXT:    movd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddd %mm0, %mm0
; X86-NEXT:    movq %mm0, (%esp)
; X86-NEXT:    movl (%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: cvtt_v2f64_v2i32:
; X64:       # BB#0:
; X64-NEXT:    cvttpd2dq %xmm0, %xmm0
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    paddd %mm0, %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    retq
  %3 = tail call <4 x i32> @llvm.x86.sse2.cvttpd2dq(<2 x double> %0)
  %4 = bitcast <4 x i32> %3 to <2 x i64>
  %5 = extractelement <2 x i64> %4, i32 0
  %6 = bitcast i64 %5 to x86_mmx
  %7 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %6, x86_mmx %6)
  %8 = bitcast x86_mmx %7 to i64
  %9 = insertelement <1 x i64> undef, i64 %8, i32 0
  store <1 x i64> %9, <1 x i64>* %1
  ret void
}

define void @fptosi_v2f64_v2i32(<2 x double>, <1 x i64>*) nounwind {
; X86-LABEL: fptosi_v2f64_v2i32:
; X86:       # BB#0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $16, %esp
; X86-NEXT:    movl 8(%ebp), %eax
; X86-NEXT:    cvttpd2dq %xmm0, %xmm0
; X86-NEXT:    movlpd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddd %mm0, %mm0
; X86-NEXT:    movq %mm0, (%esp)
; X86-NEXT:    movl (%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: fptosi_v2f64_v2i32:
; X64:       # BB#0:
; X64-NEXT:    cvttpd2dq %xmm0, %xmm0
; X64-NEXT:    movlpd %xmm0, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movq -{{[0-9]+}}(%rsp), %mm0
; X64-NEXT:    paddd %mm0, %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    retq
  %3 = fptosi <2 x double> %0 to <2 x i32>
  %4 = bitcast <2 x i32> %3 to x86_mmx
  %5 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %4, x86_mmx %4)
  %6 = bitcast x86_mmx %5 to i64
  %7 = insertelement <1 x i64> undef, i64 %6, i32 0
  store <1 x i64> %7, <1 x i64>* %1
  ret void
}

define void @cvt_v2f32_v2i32(<4 x float>, <1 x i64>*) nounwind {
; X86-LABEL: cvt_v2f32_v2i32:
; X86:       # BB#0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $16, %esp
; X86-NEXT:    movl 8(%ebp), %eax
; X86-NEXT:    cvtps2dq %xmm0, %xmm0
; X86-NEXT:    movss %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; X86-NEXT:    movd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddd %mm0, %mm0
; X86-NEXT:    movq %mm0, (%esp)
; X86-NEXT:    movl (%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: cvt_v2f32_v2i32:
; X64:       # BB#0:
; X64-NEXT:    cvtps2dq %xmm0, %xmm0
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    paddd %mm0, %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    retq
  %3 = tail call <4 x i32> @llvm.x86.sse2.cvtps2dq(<4 x float> %0)
  %4 = bitcast <4 x i32> %3 to <2 x i64>
  %5 = extractelement <2 x i64> %4, i32 0
  %6 = bitcast i64 %5 to x86_mmx
  %7 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %6, x86_mmx %6)
  %8 = bitcast x86_mmx %7 to i64
  %9 = insertelement <1 x i64> undef, i64 %8, i32 0
  store <1 x i64> %9, <1 x i64>* %1
  ret void
}

define void @cvtt_v2f32_v2i32(<4 x float>, <1 x i64>*) nounwind {
; X86-LABEL: cvtt_v2f32_v2i32:
; X86:       # BB#0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $16, %esp
; X86-NEXT:    movl 8(%ebp), %eax
; X86-NEXT:    cvttps2dq %xmm0, %xmm0
; X86-NEXT:    movd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; X86-NEXT:    movd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddd %mm0, %mm0
; X86-NEXT:    movq %mm0, (%esp)
; X86-NEXT:    movl (%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: cvtt_v2f32_v2i32:
; X64:       # BB#0:
; X64-NEXT:    cvttps2dq %xmm0, %xmm0
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    paddd %mm0, %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    retq
  %3 = tail call <4 x i32> @llvm.x86.sse2.cvttps2dq(<4 x float> %0)
  %4 = bitcast <4 x i32> %3 to <2 x i64>
  %5 = extractelement <2 x i64> %4, i32 0
  %6 = bitcast i64 %5 to x86_mmx
  %7 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %6, x86_mmx %6)
  %8 = bitcast x86_mmx %7 to i64
  %9 = insertelement <1 x i64> undef, i64 %8, i32 0
  store <1 x i64> %9, <1 x i64>* %1
  ret void
}

define void @fptosi_v2f32_v2i32(<4 x float>, <1 x i64>*) nounwind {
; X86-LABEL: fptosi_v2f32_v2i32:
; X86:       # BB#0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $16, %esp
; X86-NEXT:    movl 8(%ebp), %eax
; X86-NEXT:    cvttps2dq %xmm0, %xmm0
; X86-NEXT:    movd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; X86-NEXT:    movd %xmm0, {{[0-9]+}}(%esp)
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddd %mm0, %mm0
; X86-NEXT:    movq %mm0, (%esp)
; X86-NEXT:    movl (%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: fptosi_v2f32_v2i32:
; X64:       # BB#0:
; X64-NEXT:    cvttps2dq %xmm0, %xmm0
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    paddd %mm0, %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    retq
  %3 = fptosi <4 x float> %0 to <4 x i32>
  %4 = bitcast <4 x i32> %3 to <2 x i64>
  %5 = extractelement <2 x i64> %4, i32 0
  %6 = bitcast i64 %5 to x86_mmx
  %7 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %6, x86_mmx %6)
  %8 = bitcast x86_mmx %7 to i64
  %9 = insertelement <1 x i64> undef, i64 %8, i32 0
  store <1 x i64> %9, <1 x i64>* %1
  ret void
}

declare x86_mmx @llvm.x86.mmx.padd.d(x86_mmx, x86_mmx)
declare <4 x i32> @llvm.x86.sse2.cvtpd2dq(<2 x double>)
declare <4 x i32> @llvm.x86.sse2.cvttpd2dq(<2 x double>)
declare <4 x i32> @llvm.x86.sse2.cvtps2dq(<4 x float>)
declare <4 x i32> @llvm.x86.sse2.cvttps2dq(<4 x float>)