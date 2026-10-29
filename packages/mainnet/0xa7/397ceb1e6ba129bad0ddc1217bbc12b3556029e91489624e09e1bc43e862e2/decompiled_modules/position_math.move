module 0xa7397ceb1e6ba129bad0ddc1217bbc12b3556029e91489624e09e1bc43e862e2::position_math {
    public fun average_entry_price(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            0
        } else {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(arg0, arg1)
        }
    }

    public fun bankruptcy_price(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg0) {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(arg1 - arg2, arg3)
        } else {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(arg1 + arg2, arg3)
        }
    }

    fun from_subtraction(arg0: u128, arg1: u128) : (u128, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, true)
        } else {
            (arg1 - arg0, false)
        }
    }

    public fun funding_fee_per_unit(arg0: bool, arg1: u128, arg2: bool, arg3: u128, arg4: bool) : (u128, bool) {
        if (arg0) {
            signed_sub(arg1, arg2, arg3, arg4)
        } else {
            signed_sub(arg3, arg4, arg1, arg2)
        }
    }

    fun gt_u128(arg0: u128, arg1: bool, arg2: u128) : bool {
        !arg1 && false || arg0 > arg2
    }

    fun gte(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : bool {
        arg1 && arg3 && arg0 >= arg2 || !arg1 && !arg3 && arg0 <= arg2 || arg1
    }

    fun gte_u128(arg0: u128, arg1: bool, arg2: u128) : bool {
        !arg1 && false || arg0 >= arg2
    }

    public fun is_undercollat(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : bool {
        let (v0, v1) = margin_ratio(arg0, arg1, arg2, arg3, arg4);
        lt_u128(v0, v1, arg5)
    }

    fun lt_u128(arg0: u128, arg1: bool, arg2: u128) : bool {
        !arg1 || arg0 < arg2
    }

    public fun margin_ratio(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : (u128, bool) {
        if (arg1 == 0) {
            return (0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint(), true)
        };
        let v0 = 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg4, arg1);
        if (v0 == 0) {
            return (0, true)
        };
        if (arg0) {
            let (v3, v4) = from_subtraction(arg3, arg2);
            signed_sub(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint(), true, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(v3, v0), v4)
        } else {
            from_subtraction(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(arg3 + arg2, v0), 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint())
        }
    }

    public fun pnl_per_unit(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : (u128, bool) {
        if (arg0) {
            from_subtraction(arg3, average_entry_price(arg1, arg2))
        } else {
            from_subtraction(average_entry_price(arg1, arg2), arg3)
        }
    }

    fun signed_add(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        let (v0, v1) = if (arg1 == arg3) {
            (arg0 + arg2, arg1)
        } else if (arg0 >= arg2) {
            (arg0 - arg2, arg1)
        } else {
            (arg2 - arg0, arg3)
        };
        if (v0 == 0) {
            (0, true)
        } else {
            (v0, v1)
        }
    }

    fun signed_sub(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        signed_add(arg0, arg1, arg2, !arg3)
    }

    public fun verify_collat_checks(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: bool, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: u8, arg12: u64) {
        let (v0, v1) = margin_ratio(arg0, arg1, arg2, arg3, arg10);
        let (v2, v3) = margin_ratio(arg4, arg5, arg6, arg7, arg10);
        if (gte_u128(v2, v3, arg8)) {
            return
        };
        assert!(arg4 == arg0 && arg1 > 0, 400 + arg12);
        assert!(gte(v2, v3, v0, v1), 402 + arg12);
        assert!(gt_u128(v2, v3, arg9) || arg1 >= arg5 && arg0 == arg4, 404 + arg12);
        let v4 = if (gte_u128(v2, v3, 0)) {
            true
        } else if (arg11 == 2) {
            true
        } else {
            arg11 == 3
        };
        assert!(v4, 406 + arg12);
    }

    // decompiled from Move bytecode v7
}

