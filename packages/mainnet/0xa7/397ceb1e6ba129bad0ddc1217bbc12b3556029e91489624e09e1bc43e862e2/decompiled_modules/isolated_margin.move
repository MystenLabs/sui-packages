module 0xa7397ceb1e6ba129bad0ddc1217bbc12b3556029e91489624e09e1bc43e862e2::isolated_margin {
    struct ApplyResult has copy, drop {
        size: u128,
        margin: u128,
        oi_open: u128,
        is_long: bool,
        funds_flow_mag: u128,
        funds_flow_pos: bool,
        pnl_mag: u128,
        pnl_pos: bool,
        trade_fee: u128,
    }

    public fun apply_flip(arg0: u128, arg1: u128, arg2: u128, arg3: bool, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool, arg9: u128, arg10: u64, arg11: bool, arg12: bool) : ApplyResult {
        let v0 = arg4 - arg0;
        let v1 = 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(v0, arg5);
        let v2 = if (arg11) {
            let (v3, v4) = signed_add_u128(arg7, arg8, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(arg1, arg0));
            assert!(gte_u128(v3, v4, 0), arg10 + 46);
            let v5 = positive_value(v3, v4);
            if (arg9 > v5) {
                v5
            } else {
                arg9
            }
        } else {
            arg9
        };
        let (v6, v7) = signed_add_u128(arg7, !arg8, v2);
        let (v8, v9) = signed_mul_u128(v6, v7, arg0);
        let (v10, v11) = signed_sub_u128(v8, v9, arg1);
        let (v12, v13, v14) = if (arg12) {
            (0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(v0, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg5, arg6)), 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(v0, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(arg5, arg6) + arg9), 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div_up(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(arg0, v2) + 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(v0, arg9), arg4), arg4))
        } else {
            let v15 = 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(v1, arg6);
            (v15, v15, 0)
        };
        let (v16, v17) = signed_add_u128(v10, v11, v13);
        let (v18, v19) = signed_mul_u128(arg7, arg8, arg0);
        ApplyResult{
            size           : v0,
            margin         : v12,
            oi_open        : v1,
            is_long        : !arg3,
            funds_flow_mag : v16,
            funds_flow_pos : v17,
            pnl_mag        : v18,
            pnl_pos        : v19,
            trade_fee      : v14,
        }
    }

    public fun apply_increase(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: bool) : ApplyResult {
        let v0 = 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(arg4, arg5);
        ApplyResult{
            size           : arg0 + arg3,
            margin         : arg1 + 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg3, v0),
            oi_open        : arg2 + 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg3, arg4),
            is_long        : arg7,
            funds_flow_mag : 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(arg3, v0 + arg6),
            funds_flow_pos : true,
            pnl_mag        : 0,
            pnl_pos        : true,
            trade_fee      : 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(arg6, arg3),
        }
    }

    public fun apply_reduce(arg0: u128, arg1: u128, arg2: u128, arg3: bool, arg4: u128, arg5: u128, arg6: bool, arg7: u128, arg8: u64, arg9: bool, arg10: u128, arg11: bool, arg12: bool) : ApplyResult {
        let v0 = arg0 - arg4;
        if (arg9) {
            let (v1, v2) = signed_add_u128(arg5, arg6, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(arg1, arg0));
            let (v3, v4) = signed_add_u128(v1, v2, arg10);
            assert!(gte_u128(v3, v4, 0), arg8 + 46);
            let v5 = positive_value(v1, v2);
            if (arg7 > v5) {
                arg7 = v5;
            };
        };
        let (v6, v7) = if (arg12) {
            (0, true)
        } else {
            let (v8, v9) = signed_add_u128(arg5, !arg6, arg7);
            let (v10, v11) = signed_mul_u128(v8, v9, arg4);
            signed_sub_u128(v10, v11, arg1 * arg4 / arg0)
        };
        let v12 = v7;
        let v13 = v6;
        if (arg11) {
            let (v14, v15) = negative_number(v6, v7);
            v12 = v15;
            v13 = v14;
        };
        let (v16, v17) = signed_mul_u128(arg5, arg6, arg4);
        ApplyResult{
            size           : v0,
            margin         : arg1 * v0 / arg0,
            oi_open        : arg2 * v0 / arg0,
            is_long        : arg3,
            funds_flow_mag : v13,
            funds_flow_pos : v12,
            pnl_mag        : v16,
            pnl_pos        : v17,
            trade_fee      : 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul_up(arg7, arg4),
        }
    }

    public fun calculate_premium(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : (u128, bool) {
        let (v0, v1) = if (arg0) {
            from_subtraction(arg2, arg3)
        } else {
            from_subtraction(arg3, arg2)
        };
        signed_mul_u128(v0, v1, arg1)
    }

    fun from_subtraction(arg0: u128, arg1: u128) : (u128, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, true)
        } else {
            (arg1 - arg0, false)
        }
    }

    public fun funds_flow(arg0: &ApplyResult) : (u128, bool) {
        (arg0.funds_flow_mag, arg0.funds_flow_pos)
    }

    fun gte_u128(arg0: u128, arg1: bool, arg2: u128) : bool {
        !arg1 && false || arg0 >= arg2
    }

    public fun is_long(arg0: &ApplyResult) : bool {
        arg0.is_long
    }

    public fun margin(arg0: &ApplyResult) : u128 {
        arg0.margin
    }

    fun negative_number(arg0: u128, arg1: bool) : (u128, bool) {
        if (!arg1) {
            if (arg0 == 0) {
                (0, true)
            } else {
                (arg0, false)
            }
        } else {
            (0, true)
        }
    }

    public fun oi_open(arg0: &ApplyResult) : u128 {
        arg0.oi_open
    }

    public fun pnl(arg0: &ApplyResult) : (u128, bool) {
        (arg0.pnl_mag, arg0.pnl_pos)
    }

    fun positive_value(arg0: u128, arg1: bool) : u128 {
        if (!arg1) {
            0
        } else {
            arg0
        }
    }

    fun signed_add_u128(arg0: u128, arg1: bool, arg2: u128) : (u128, bool) {
        if (arg1) {
            (arg0 + arg2, true)
        } else if (arg0 > arg2) {
            (arg0 - arg2, false)
        } else {
            (arg2 - arg0, true)
        }
    }

    fun signed_mul_u128(arg0: u128, arg1: bool, arg2: u128) : (u128, bool) {
        let v0 = 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg0, arg2);
        if (v0 == 0) {
            (0, true)
        } else {
            (v0, arg1)
        }
    }

    fun signed_sub_u128(arg0: u128, arg1: bool, arg2: u128) : (u128, bool) {
        if (!arg1) {
            (arg0 + arg2, false)
        } else if (arg0 > arg2) {
            (arg0 - arg2, true)
        } else {
            (arg2 - arg0, false)
        }
    }

    public fun size(arg0: &ApplyResult) : u128 {
        arg0.size
    }

    public fun trade_fee(arg0: &ApplyResult) : u128 {
        arg0.trade_fee
    }

    // decompiled from Move bytecode v7
}

