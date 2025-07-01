module 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_turbos {
    public fun calculate_minimum_output(arg0: u64, arg1: u64) : u64 {
        arg0 * 9975 / 10000 * (10000 - arg1) / 10000
    }

    public fun check_token_compatibility() : bool {
        true
    }

    public fun get_fee_tier() : u64 {
        25
    }

    public fun get_min_trade_amount() : u64 {
        100
    }

    public fun get_swap_function_name() : vector<u8> {
        b"swap_a_b"
    }

    public fun get_swap_params_a_to_b() : (bool, bool) {
        (true, true)
    }

    public fun get_swap_params_b_to_a() : (bool, bool) {
        (false, true)
    }

    public fun get_turbos_module() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun supports_buck() : bool {
        true
    }

    public fun supports_concentrated_liquidity() : bool {
        true
    }

    public fun supports_wusdc() : bool {
        true
    }

    public fun validate_amount_constraints(arg0: u64, arg1: u64) : bool {
        if (arg0 >= get_min_trade_amount()) {
            if (arg1 > 0) {
                arg1 <= arg0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_pool(arg0: address) : bool {
        arg0 != @0x0 && arg0 != @0x1
    }

    public fun validate_swap_params<T0, T1>(arg0: &0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64) : bool {
        if (0x2::coin::value<T0>(arg0) > 0) {
            if (arg2 > 0) {
                0x2::object::id_to_address(&arg1) != @0x0
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

