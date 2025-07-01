module 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::atomic_arbitrage {
    public entry fun arb_aftermath_bluefin_usdt<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_aftermath::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_aftermath::calculate_minimum_output(v0, 50)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_aftermath_cetus_wusdc<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_aftermath::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_aftermath::calculate_minimum_output(v0, 50)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_cetus_aftermath_buck<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_cetus_aftermath_usdt<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_cetus_aftermath_wusdc<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_cetus::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_cetus::calculate_minimum_output(v0, 100)), 1);
        let (_, _, _) = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_cetus::get_sui_to_wusdc_params();
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_kriya_cetus_wusdc<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_kriya::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_kriya::calculate_minimum_output(v0, 100)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_turbos_deepbook_buck<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_turbos::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_turbos::calculate_minimum_output(v0, 75)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun block_complex_routing() {
        abort 3
    }

    public fun block_exotic_tokens() {
        abort 4
    }

    public fun get_approved_tokens() : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN");
        0x1::vector::push_back<vector<u8>>(v1, b"0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN");
        0x1::vector::push_back<vector<u8>>(v1, b"0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK");
        v0
    }

    public fun get_dex_addresses() : (address, address) {
        (0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_cetus::get_cetus_module(), 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::dex_aftermath::get_aftermath_module())
    }

    fun is_approved_intermediate_token<T0>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0));
        let v2 = b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN";
        if (v1 == &v2) {
            true
        } else {
            let v4 = b"0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN";
            if (v1 == &v4) {
                true
            } else {
                let v5 = b"0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK";
                v1 == &v5
            }
        }
    }

    public fun validate_atomic_execution_ready(arg0: u64, arg1: bool, arg2: bool) : bool {
        if (arg0 >= 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount()) {
            if (arg1) {
                arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_hop_count() : u8 {
        2
    }

    public fun validate_pattern_compliance<T0>(arg0: u64) : bool {
        arg0 == 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount() && is_approved_intermediate_token<T0>()
    }

    public fun validate_simple_pattern_compliance<T0>(arg0: u64, arg1: bool, arg2: bool) : bool {
        if (arg0 == 0x1f76914872e151dadfe100eaa74dd2032730bcfbffc7ee146d697fac495a172d::constants::sui_input_amount()) {
            if (validate_single_token_route_only<T0>()) {
                if (arg1) {
                    arg2
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

    fun validate_single_intermediate_token<T0>() {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::borrow_string(&v0);
        let v2 = b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN";
        let v3 = b"0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN";
        let v4 = b"0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK";
        let v5 = if (0x1::ascii::as_bytes(v1) == &v2) {
            true
        } else if (0x1::ascii::as_bytes(v1) == &v3) {
            true
        } else {
            0x1::ascii::as_bytes(v1) == &v4
        };
        assert!(v5, 2);
    }

    public fun validate_single_token_route_only<T0>() : bool {
        validate_hop_count() == 2 && is_approved_intermediate_token<T0>()
    }

    // decompiled from Move bytecode v6
}

