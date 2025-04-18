module 0xa3ae89c38ed81e443d3954ace58ca682ee3705b735d088e7a552b31c59f72f8c::quote {
    fun calc_reverse_swap_out_a(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg1 > 0 && arg2 > 0, 4);
        let v0 = if (arg4 > 0) {
            ceil_muldiv(arg0, arg4, 2 * 10000)
        } else {
            0
        };
        let v1 = arg0 + v0;
        let v2 = muldiv(v1, arg1, arg2 - v1);
        let v3 = if (arg4 > 0) {
            ceil_muldiv(v2, arg4, 2 * 10000)
        } else {
            0
        };
        let v4 = if (arg3 > 0) {
            ceil_muldiv(v2, arg3, 10000)
        } else {
            0
        };
        let v5 = if (arg5 > 0) {
            ceil_muldiv(v2, arg5, 10000)
        } else {
            0
        };
        let v6 = if (arg6 > 0) {
            ceil_muldiv(v2, arg6, 10000)
        } else {
            0
        };
        let v7 = if (arg7 > 0) {
            ceil_muldiv(v2, arg7, 10000)
        } else {
            0
        };
        (v2 + v3 + v4 + v5 + v6 + v7, v3, v0, v4, v5, v6, v7)
    }

    fun calc_reverse_swap_out_b(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg2 > 0 && arg1 > 0, 4);
        let v0 = if (arg4 > 0) {
            ceil_muldiv(arg0, arg4, 2 * 10000)
        } else {
            0
        };
        let v1 = arg0 + v0;
        let v2 = muldiv(v1, arg2, arg1 - v1);
        let v3 = if (arg4 > 0) {
            ceil_muldiv(v2, arg4, 2 * 10000)
        } else {
            0
        };
        let v4 = if (arg3 > 0) {
            ceil_muldiv(v2, arg3, 10000)
        } else {
            0
        };
        let v5 = if (arg5 > 0) {
            ceil_muldiv(v2, arg5, 10000)
        } else {
            0
        };
        let v6 = if (arg6 > 0) {
            ceil_muldiv(v2, arg6, 10000)
        } else {
            0
        };
        let v7 = if (arg7 > 0) {
            ceil_muldiv(v2, arg7, 10000)
        } else {
            0
        };
        (v2 + v3 + v4 + v5 + v6 + v7, v3, v0, v4, v5, v6, v7)
    }

    fun calc_swap_out_a(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg2 > 0 && arg1 > 0, 4);
        let v0 = if (arg4 > 0) {
            ceil_muldiv(arg0, arg4, 2 * 10000)
        } else {
            0
        };
        let v1 = arg0 - v0;
        let v2 = muldiv(v1, arg1, arg2 + v1);
        let v3 = if (arg3 > 0) {
            ceil_muldiv(v2, arg3, 10000)
        } else {
            0
        };
        let v4 = if (arg5 > 0) {
            ceil_muldiv(v2, arg5, 10000)
        } else {
            0
        };
        let v5 = if (arg6 > 0) {
            ceil_muldiv(v2, arg6, 10000)
        } else {
            0
        };
        let v6 = if (arg7 > 0) {
            ceil_muldiv(v2, arg7, 10000)
        } else {
            0
        };
        let v7 = if (arg4 > 0) {
            ceil_muldiv(v2, arg4, 2 * 10000)
        } else {
            0
        };
        (v2 - v3 - v4 - v5 - v6 - v7, v0, v7, v3, v4, v5, v6)
    }

    fun calc_swap_out_b(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg1 > 0 && arg2 > 0, 4);
        let v0 = if (arg4 > 0) {
            ceil_muldiv(arg0, arg4, 2 * 10000)
        } else {
            0
        };
        let v1 = if (arg3 > 0) {
            ceil_muldiv(arg0, arg3, 10000)
        } else {
            0
        };
        let v2 = if (arg5 > 0) {
            ceil_muldiv(arg0, arg5, 10000)
        } else {
            0
        };
        let v3 = if (arg6 > 0) {
            ceil_muldiv(arg0, arg6, 10000)
        } else {
            0
        };
        let v4 = if (arg7 > 0) {
            ceil_muldiv(arg0, arg7, 10000)
        } else {
            0
        };
        let v5 = arg0 - v0 - v1 - v2 - v3 - v4;
        let v6 = muldiv(v5, arg2, arg1 + v5);
        let v7 = if (arg4 > 0) {
            ceil_muldiv(v6, arg4, 2 * 10000)
        } else {
            0
        };
        (v6 - v7, v0, v7, v1, v2, v3, v4)
    }

    fun ceil_div_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    fun ceil_muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 / (arg2 as u128) <= 18446744073709551615, 0);
        (ceil_div_u128(v0, (arg2 as u128)) as u64)
    }

    public fun get_swap_quote_by_buy(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg2 > 0 && arg3 > 0, 4);
        if (arg1) {
            calc_reverse_swap_out_a(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        } else {
            calc_reverse_swap_out_b(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        }
    }

    public fun get_swap_quote_by_sell(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg2 > 0 && arg3 > 0, 4);
        if (arg1) {
            calc_swap_out_b(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        } else {
            calc_swap_out_a(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        }
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

