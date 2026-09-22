module 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math {
    public(friend) fun absorb_funding_cost(arg0: u64, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x1::u64::min(arg0, arg1);
        (arg0 - v0, v0, arg1 - v0)
    }

    public(friend) fun admin_share_down(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 1);
        0x1::u64::mul_div(arg0, arg1, 10000)
    }

    public(friend) fun allocated_mint_quote(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64, u64) {
        let v0 = shareholder_nav(arg0, arg2);
        let v1 = shareholder_nav(arg1, arg3);
        assert!(v1 > v0, 5);
        let v2 = 0x1::u64::min(v1 - v0, arg4);
        let v3 = mint_quote(v2, v0, arg5);
        assert!(v3 >= arg6, 35);
        (v1, v2, v3)
    }

    public(friend) fun assert_mint_base_within_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let (v0, v1) = mint_base_bounds(arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x1::u64::checked_add(arg3, v1);
        if (0x1::option::is_some<u64>(&v2)) {
            assert!(arg0 <= 0x1::option::destroy_some<u64>(v2), 19);
            assert!(arg0 >= arg3 + v0, 20);
            return
        } else {
            0x1::option::destroy_none<u64>(v2);
            abort 15
        };
    }

    public(friend) fun assert_redemption_base_within_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let (v0, v1) = redemption_base_bounds(arg1, arg2, arg3, arg4, arg5);
        assert!(arg0 <= v1, 13);
        assert!(arg0 >= v0, 14);
    }

    fun credit_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = 0x1::u64::checked_add(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 15
        };
    }

    public(friend) fun fee_allocation(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = fee_up(arg0, arg1);
        let v1 = admin_share_down(v0, arg2);
        (v0, v1, v0 - v1)
    }

    fun fee_up(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0, 0);
        assert!(arg1 < 10000, 1);
        0x1::u64::mul_div_ceil(arg0, arg1, 10000)
    }

    public(friend) fun is_accounting_leverage_below_limit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (is_shareholder_nav_positive(arg1, arg2)) {
            if (arg3 > 0) {
                leverage_bps_up(arg0, arg1 - arg2) < (arg3 as u128)
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun is_base_above_min_order(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg1 > 0) {
            if (arg2 > 0) {
                (arg0 as u128) > (arg1 as u128) * (arg2 as u128)
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun is_reserve_backed(arg0: u64, arg1: u64) : bool {
        arg1 <= arg0
    }

    public(friend) fun is_shareholder_nav_positive(arg0: u64, arg1: u64) : bool {
        arg1 < arg0
    }

    fun leverage_bps_up(arg0: u64, arg1: u64) : u128 {
        0x1::u128::mul_div_ceil((arg0 as u128), 10000, (arg1 as u128))
    }

    fun mint_base_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = mint_base_to_buy_down(arg0, arg2, arg3, arg4, arg5);
        (0x1::u64::min(mint_base_to_buy_down(arg1, arg2, arg3, arg4, arg5), v0), v0)
    }

    public(friend) fun mint_base_to_buy_down(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg2 > 0, 2);
        assert!(arg1 > 0, 11);
        assert!(arg3 > 0, 10);
        assert!(arg4 > 0, 21);
        let v0 = narrow_to_u64((arg1 as u128) * (arg0 as u128) / (arg2 as u128));
        assert!((v0 as u128) >= (arg3 as u128) * (arg4 as u128), 12);
        v0 - v0 % arg3
    }

    fun mint_quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 2);
        assert!(arg2 > 0, 3);
        assert!(arg0 > 0, 5);
        let v0 = narrow_to_u64((arg2 as u128) * (arg0 as u128) / (arg1 as u128));
        assert!(v0 > 0, 6);
        let v1 = 0x1::u64::checked_add(arg2, v0);
        assert!(0x1::option::is_some<u64>(&v1), 15);
        v0
    }

    fun narrow_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 15);
        (arg0 as u64)
    }

    public(friend) fun redemption_accounting_quote(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let v0 = shareholder_nav(arg2, arg3);
        let (v1, v2, v3) = redemption_quote(arg0, shareholder_nav(arg1, arg3), v0, arg4, arg5);
        (credit_fee(arg3, v2), v0 - v1, v2, v3)
    }

    public(friend) fun redemption_base_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        assert!(arg0 > 0 && arg0 < arg2, 4);
        assert!(arg3 > 0, 10);
        assert!(arg4 > 0, 21);
        let v0 = 0x1::u64::mul_div(arg1, arg2 - arg0, arg2);
        let v1 = arg1 - v0;
        assert!(v0 == 0 || (v1 as u128) >= (arg3 as u128) * (arg4 as u128), 12);
        (arg1 - (0x1::u128::min(0x1::u128::div_ceil((v1 as u128), (arg3 as u128)) * (arg3 as u128), (arg1 as u128)) as u64), v0)
    }

    fun redemption_quote(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        assert!(arg1 > 0, 2);
        assert!(arg0 > 0 && arg0 < arg3, 4);
        assert!(arg4 < 10000, 1);
        let v0 = 0x1::u64::mul_div_ceil(arg1, arg3 - arg0, arg3);
        let v1 = 0x1::u64::min(arg2, arg1);
        assert!(v1 > v0, 7);
        let v2 = v1 - v0;
        let v3 = fee_up(v2, arg4);
        let v4 = v2 - v3;
        assert!(v4 > 0, 8);
        (v2, v3, v4)
    }

    public(friend) fun shareholder_nav(arg0: u64, arg1: u64) : u64 {
        assert!(is_reserve_backed(arg0, arg1), 16);
        arg0 - arg1
    }

    public(friend) fun target_notional_down(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0, 2);
        assert!(arg1 > 0, 9);
        narrow_to_u64((arg0 as u128) * (arg1 as u128) / 10000)
    }

    // decompiled from Move bytecode v7
}

