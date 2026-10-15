module 0xf752158c5953b9e751ec12f4e0332d25e497a9d5acd15fd71a06234b8e4d585c::guard {
    public fun check_clmm(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64) {
        let v0 = if (arg3 > 0) {
            if (arg3 <= arg4) {
                arg5 <= arg6
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg0 >= arg3 && arg0 <= arg4, 2);
        assert!(arg1 >= arg5 && arg1 <= arg6, 3);
        assert!(arg2 == arg7, 4);
    }

    public fun check_clmm_u32(arg0: u128, arg1: u128, arg2: u32, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64) {
        check_clmm(arg0, arg1, (arg2 as u64), arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v7
}

