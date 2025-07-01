module 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_aftermath {
    public fun calculate_minimum_output(arg0: u64, arg1: u64) : u64 {
        arg0 * (10000 - arg1) / 10000
    }

    public fun check_token_compatibility() : bool {
        true
    }

    public fun get_aftermath_module() : address {
        0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::aftermath_package()
    }

    public fun get_min_trade_amount() : u64 {
        100
    }

    public fun get_protocol_blacklist() : vector<vector<u8>> {
        vector[b"FlowX", b"Scallop", b"Haedal"]
    }

    public fun get_protocol_whitelist() : vector<vector<u8>> {
        vector[b"Aftermath", b"Cetus", b"Turbos", b"Kriya", b"Bluefin", b"DeepBook"]
    }

    public fun get_recommended_slippage() : u64 {
        50
    }

    public fun get_router_function_name() : vector<u8> {
        b"swap_exact_coin_for_coin"
    }

    public fun is_protocol_compliant(arg0: vector<u8>) : bool {
        let v0 = get_protocol_whitelist();
        let v1 = get_protocol_blacklist();
        0x1::vector::contains<vector<u8>>(&v0, &arg0) && !0x1::vector::contains<vector<u8>>(&v1, &arg0)
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

    public fun validate_single_token_route<T0>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0));
        let v2 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::wusdc_type();
        if (v1 == &v2) {
            true
        } else {
            let v4 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::usdt_type();
            if (v1 == &v4) {
                true
            } else {
                let v5 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::buck_type();
                v1 == &v5
            }
        }
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

