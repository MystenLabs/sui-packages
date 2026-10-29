module 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance {
    struct Quote has copy, drop {
        status: u8,
        pt: u64,
        cost: u64,
        lp: u64,
        refund: u64,
        pt_dust: u64,
        iterations: u64,
        blocked_pt: u64,
        spend_upper: u256,
    }

    public fun accounted_sy(arg0: u64, arg1: u64, arg2: u64) : u128 {
        (arg0 as u128) + (arg1 as u128) + (arg2 as u128)
    }

    public fun amounts(arg0: &Quote) : (u64, u64, u64, u64, u64) {
        (arg0.pt, arg0.cost, arg0.lp, arg0.refund, arg0.pt_dust)
    }

    public(friend) fun capacity(arg0: u64, arg1: u64, arg2: u64, arg3: u256) : Quote {
        Quote{
            status      : curve_limit(),
            pt          : 0,
            cost        : 0,
            lp          : 0,
            refund      : arg0,
            pt_dust     : 0,
            iterations  : arg1,
            blocked_pt  : arg2,
            spend_upper : arg3,
        }
    }

    public fun ceil_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 0);
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    public fun certificate(arg0: &Quote) : (u64, u256, u64) {
        (arg0.blocked_pt, arg0.spend_upper, arg0.iterations)
    }

    public fun curve_limit() : u8 {
        2
    }

    public fun invalid_input() : u8 {
        0
    }

    public fun is_full(arg0: u64, arg1: u64) : bool {
        if (arg0 > 1) {
            if (arg1 < arg0) {
                arg1 <= refund_limit(arg0)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_keep_full(arg0: u64, arg1: u64) : bool {
        arg0 > 1 && arg1 < arg0
    }

    public fun needs_more_pt(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        (arg0 as u256) * (arg2 as u256) < (arg3 as u256) * (arg1 as u256)
    }

    public fun position_delta_valid(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : bool {
        if (arg3 >= arg0) {
            if (arg4 >= arg1) {
                if (arg5 >= arg2) {
                    if (arg4 - arg1 == arg7) {
                        if (arg5 - arg2 == arg6) {
                            if (arg6 > 0) {
                                arg6 >= arg8
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun precision_unresolved() : u8 {
        3
    }

    public fun prefer(arg0: Quote, arg1: Quote) : Quote {
        let v0 = if (arg1.status == success()) {
            if (arg0.status != success()) {
                true
            } else if (arg1.lp > arg0.lp) {
                true
            } else {
                arg1.lp == arg0.lp && (arg1.refund < arg0.refund || arg1.refund == arg0.refund && arg1.pt_dust < arg0.pt_dust)
            }
        } else {
            false
        };
        if (v0) {
            arg1
        } else {
            arg0
        }
    }

    public fun project(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : Quote {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 <= arg4) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg5 == 0) {
            true
        } else if (arg5 >= arg3) {
            true
        } else if (arg6 > arg5) {
            true
        } else {
            (arg2 as u128) + (arg5 as u128) > 18446744073709551615
        };
        if (v0) {
            return unavailable(invalid_input(), arg3, arg7)
        };
        let v1 = arg1 - arg4;
        let v2 = arg2 + arg5 - arg6;
        let (v3, v4, v5) = project_add(arg0, v1, v2, arg4, arg3 - arg5);
        if (v3 == 0) {
            return unavailable(precision_unresolved(), arg3, arg7)
        };
        let v6 = arg3 - arg5 - v5 - v2;
        let v7 = arg4 - v4 - v1;
        let v8 = if (is_full(arg3, v6) && (v7 as u128) <= ((v1 as u128) + (arg0 as u128) - 1) / (arg0 as u128) + 1) {
            success()
        } else {
            precision_unresolved()
        };
        Quote{
            status      : v8,
            pt          : arg4,
            cost        : arg5,
            lp          : v3,
            refund      : v6,
            pt_dust     : v7,
            iterations  : arg7,
            blocked_pt  : 0,
            spend_upper : 0,
        }
    }

    public fun project_add(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return (0, 0, 0)
        };
        let v1 = 0x1::u128::min((arg3 as u128) * (arg0 as u128) / (arg1 as u128), (arg4 as u128) * (arg0 as u128) / (arg2 as u128));
        if (v1 == 0 || v1 > 18446744073709551615 - (arg0 as u128)) {
            return (0, 0, 0)
        };
        let v2 = (v1 * (arg1 as u128) + (arg0 as u128) - 1) / (arg0 as u128);
        let v3 = (v1 * (arg2 as u128) + (arg0 as u128) - 1) / (arg0 as u128);
        let v4 = if (v2 > (arg3 as u128)) {
            true
        } else if (v3 > (arg4 as u128)) {
            true
        } else if (v2 + (arg1 as u128) > 18446744073709551615) {
            true
        } else {
            v3 + (arg2 as u128) > 18446744073709551615
        };
        if (v4) {
            return (0, 0, 0)
        };
        ((v1 as u64), ((v2 + (arg1 as u128)) as u64), ((v3 + (arg2 as u128)) as u64))
    }

    public fun refund_limit(arg0: u64) : u64 {
        0x1::u64::max(1, arg0 / 1000000)
    }

    public fun reserve_fee(arg0: u64, arg1: u128, arg2: u128) : u64 {
        assert!(arg1 <= (18446744073709551616 as u128) && arg2 < (18446744073709551616 as u128), 0);
        ((((arg0 as u256) * (arg1 as u256) + (arg2 as u256)) / 18446744073709551616) as u64)
    }

    public fun search_incomplete() : u8 {
        4
    }

    public fun spend_upper_bound(arg0: u64, arg1: u64, arg2: u128, arg3: u64) : u256 {
        assert!(arg2 > 0 && arg3 < arg0, 0);
        let v0 = ceil_div((arg3 as u256) * 18446744073709551616, (arg2 as u256));
        v0 + ceil_div((arg3 as u256) * ((arg1 as u256) + v0), ((arg0 - arg3) as u256))
    }

    public fun status(arg0: &Quote) : u8 {
        arg0.status
    }

    public fun success() : u8 {
        1
    }

    public fun sy_is_conserved(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : bool {
        (arg1 as u256) + (arg3 as u256) == (arg0 as u256) + (arg2 as u256)
    }

    public(friend) fun unavailable(arg0: u8, arg1: u64, arg2: u64) : Quote {
        Quote{
            status      : arg0,
            pt          : 0,
            cost        : 0,
            lp          : 0,
            refund      : arg1,
            pt_dust     : 0,
            iterations  : arg2,
            blocked_pt  : 0,
            spend_upper : 0,
        }
    }

    public fun upper_rate_below_fee(arg0: u128, arg1: bool, arg2: u128, arg3: u128, arg4: bool, arg5: u128) : bool {
        assert!(arg2 > 0, 0);
        let v0 = if (arg1) {
            ceil_div((arg0 as u256) * 18446744073709551616, (arg2 as u256))
        } else {
            (arg0 as u256) * 18446744073709551616 / (arg2 as u256)
        };
        let v1 = if (arg1) {
            v0
        } else {
            0
        };
        let v2 = if (arg4) {
            (arg3 as u256)
        } else {
            0
        };
        let v3 = if (arg1) {
            0
        } else {
            v0
        };
        let v4 = if (arg4) {
            0
        } else {
            (arg3 as u256)
        };
        v1 + v2 < v3 + v4 + (arg5 as u256)
    }

    public(friend) fun with_iterations(arg0: Quote, arg1: u64) : Quote {
        arg0.iterations = arg1;
        arg0
    }

    // decompiled from Move bytecode v7
}

