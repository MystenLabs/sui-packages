module 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::stream_utils {
    public fun max_beneficiaries() : u64 {
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::actions_constants::max_beneficiaries()
    }

    public fun advance_claim_tracking(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = arg1 + arg2;
        (arg0 + v0 / arg3, v0 % arg3)
    }

    public fun calculate_available_with_tracking(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x1::option::Option<u64>) : (u64, u64, u64) {
        let (v0, _, v2) = iteration_window_state(arg3, arg4, arg5, arg6, arg7);
        let v3 = if (arg1 < v2) {
            v2
        } else {
            arg1
        };
        let v4 = if (arg1 < v2) {
            0
        } else {
            arg2
        };
        if (v0 <= v3) {
            return (0, v3, v4)
        };
        let v5 = iteration_amount(v0 - v3, arg0);
        let v6 = if (v5 > v4) {
            v5 - v4
        } else {
            0
        };
        (v6, v3, v4)
    }

    fun iteration_amount(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    fun iteration_window_state(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x1::option::Option<u64>) : (u64, u64, u64) {
        if (arg3 < arg0) {
            return (0, 0, 0)
        };
        let v0 = (arg3 - arg0) / arg2;
        let v1 = if (v0 > arg1) {
            arg1
        } else {
            v0
        };
        if (v1 == 0) {
            return (0, 0, 0)
        };
        if (0x1::option::is_none<u64>(arg4)) {
            return (v1, v1, 0)
        };
        let v2 = ((((*0x1::option::borrow<u64>(arg4) as u128) + (arg2 as u128) - 1) / (arg2 as u128)) as u64);
        let v3 = if (arg3 > arg0) {
            arg3 - arg0
        } else {
            0
        };
        let v4 = v3 / arg2;
        let v5 = if (v4 > v2) {
            v4 - v2
        } else {
            0
        };
        let v6 = if (v5 > v1) {
            v1
        } else {
            v5
        };
        (v1, v1 - v6, v6)
    }

    public fun split_vested_unvested_with_tracking(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x1::option::Option<u64>) : (u64, u64) {
        let (v0, _, _) = calculate_available_with_tracking(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        let v3 = if (v0 > arg3) {
            arg3
        } else {
            v0
        };
        (v3, arg3 - v3)
    }

    public fun validate_iteration_parameters(arg0: u64, arg1: u64, arg2: u64, arg3: &0x1::option::Option<u64>, arg4: u64) : bool {
        if (arg1 == 0) {
            return false
        };
        if (arg2 == 0) {
            return false
        };
        if ((arg0 as u128) + (arg1 as u128) * (arg2 as u128) > 18446744073709551615) {
            return false
        };
        if (0x1::option::is_some<u64>(arg3)) {
            if (*0x1::option::borrow<u64>(arg3) < arg2) {
                return false
            };
        };
        true
    }

    // decompiled from Move bytecode v6
}

