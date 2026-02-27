module 0xf6b7f168ea69e963aef85def20e6a0e8f7e3cac20f1a395927f9af53d6dd0e::orders {
    public fun apply_inventory_skew(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let (v0, _, _) = calculate_skewed_mid_price(arg0, arg1, arg2, arg3);
        v0
    }

    public fun calculate_ask_price(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 10000, 1);
        assert!(arg0 > 0, 2);
        arg0 * (10000 + arg1) / 10000
    }

    public fun calculate_ask_quantity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        let v1 = v0;
        if (v0 > arg3) {
            v1 = arg3;
        };
        if (v1 < arg2) {
            return 0
        };
        v1
    }

    public fun calculate_ask_quantity_with_reserve(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = arg0 * arg4 / 10000;
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        let v2 = v1;
        if (v1 > arg3) {
            v2 = arg3;
        };
        if (v2 < arg2) {
            return 0
        };
        v2
    }

    public fun calculate_bid_ask(arg0: u64, arg1: u64) : (u64, u64) {
        (calculate_bid_price(arg0, arg1), calculate_ask_price(arg0, arg1))
    }

    public fun calculate_bid_price(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 10000, 1);
        assert!(arg0 > 0, 2);
        arg0 * (10000 - arg1) / 10000
    }

    public fun calculate_bid_quantity(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        assert!(arg1 > 0, 2);
        calculate_order_quantity(arg0 * 1000000000 / arg1, arg2, arg3, arg4, arg5)
    }

    public fun calculate_bid_quantity_with_reserve(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        assert!(arg1 > 0, 2);
        calculate_order_quantity(arg0 * arg6 / 10000 * 1000000000 / arg1, arg2, arg3, arg4, arg5)
    }

    public fun calculate_order_quantity(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg1 >= arg2) {
            0
        } else {
            arg2 - arg1
        };
        let v1 = arg0;
        if (arg0 > v0) {
            v1 = v0;
        };
        if (v1 > arg4) {
            v1 = arg4;
        };
        if (v1 < arg3) {
            return 0
        };
        v1
    }

    public fun calculate_order_quantity_with_reserve(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        calculate_order_quantity(arg0 * arg5 / 10000, arg1, arg2, arg3, arg4)
    }

    public fun calculate_skewed_mid_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, bool) {
        if (arg2 == 0 || arg3 == 0) {
            return (arg0, 0, false)
        };
        let (v0, v1) = if (arg1 >= arg2) {
            (arg1 - arg2, true)
        } else {
            (arg2 - arg1, false)
        };
        let v2 = if (v0 >= arg2) {
            10000
        } else {
            v0 * 10000 / arg2
        };
        let v3 = v2 * arg3 / 10000;
        let v4 = if (v1) {
            arg0 * (10000 - v3) / 10000
        } else {
            arg0 * (10000 + v3) / 10000
        };
        (v4, v3, v1)
    }

    public fun convert_pyth_to_deepbook_price(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg2 >= arg1) {
            arg0 * pow10(((arg2 - arg1) as u64))
        } else {
            arg0 / pow10(((arg1 - arg2) as u64))
        }
    }

    public fun is_ask_price_valid(arg0: u64, arg1: u64) : bool {
        arg0 <= arg1
    }

    public fun is_bid_price_valid(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1
    }

    public fun is_order_viable(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 >= arg2 && arg1 > 0
    }

    public fun is_price_in_bounds(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 >= arg1 && arg0 <= arg2
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun pyth_to_sui_dbusdc_price(arg0: u64) : u64 {
        arg0 / 1000
    }

    public fun round_ask_price(arg0: u64, arg1: u64) : u64 {
        round_price_up(arg0, arg1)
    }

    public fun round_bid_price(arg0: u64, arg1: u64) : u64 {
        round_price_down(arg0, arg1)
    }

    public fun round_price_down(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 4);
        arg0 / arg1 * arg1
    }

    public fun round_price_up(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 4);
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            arg0
        } else {
            arg0 + arg1 - v0
        }
    }

    public fun round_to_lot(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 4);
        arg0 / arg1 * arg1
    }

    // decompiled from Move bytecode v6
}

