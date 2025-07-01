module 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_kriya {
    public fun calculate_minimum_output(arg0: u64, arg1: u64) : u64 {
        arg0 * 997 / 1000 * (10000 - arg1) / 10000
    }

    public fun check_token_compatibility() : bool {
        true
    }

    public fun get_min_trade_amount() : u64 {
        1000
    }

    public fun get_sui_wusdc_pool() : address {
        @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305
    }

    public fun get_swap_function_name() : vector<u8> {
        b"swap_token_y"
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
        arg0 == @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305
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

