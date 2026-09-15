module 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::session_policy {
    public fun allows(arg0: bool, arg1: u8, arg2: bool, arg3: bool) : bool {
        if (!arg0) {
            true
        } else if (!arg3) {
            true
        } else {
            arg1 == 0 && !arg2
        }
    }

    public fun assert_allowed(arg0: bool, arg1: u8, arg2: bool, arg3: bool) {
        assert!(allows(arg0, arg1, arg2, arg3), 1);
    }

    public fun exit_fee(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u8, arg5: bool, arg6: u8) : u64 {
        let v0 = if (arg6 == 0) {
            if (arg3) {
                arg4 != 0 || arg5
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::math::mul_div_ceil(arg0, arg2, 10000)
        } else {
            arg1
        }
    }

    // decompiled from Move bytecode v7
}

