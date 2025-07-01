module 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::atomic_arbitrage {
    public entry fun arb_aftermath_bluefin_usdt<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_aftermath::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_aftermath::calculate_minimum_output(v0, 50)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_aftermath_cetus_wusdc<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_aftermath::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_aftermath::calculate_minimum_output(v0, 50)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_cetus_aftermath_buck<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_cetus_aftermath_usdt<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_cetus_aftermath_wusdc<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_cetus::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_cetus::calculate_minimum_output(v0, 100)), 1);
        let (_, _, _) = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_cetus::get_sui_to_wusdc_params();
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_kriya_cetus_wusdc<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_kriya::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_kriya::calculate_minimum_output(v0, 100)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_turbos_deepbook_buck<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3);
        assert!(0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_turbos::validate_swap_params<0x2::sui::SUI, T0>(&v1, arg1, 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_turbos::calculate_minimum_output(v0, 75)), 1);
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
        0x1::vector::push_back<vector<u8>>(v1, b"wUSDC");
        0x1::vector::push_back<vector<u8>>(v1, b"USDT");
        0x1::vector::push_back<vector<u8>>(v1, b"BUCK");
        v0
    }

    public fun get_dex_addresses() : (address, address) {
        (0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_cetus::get_cetus_module(), 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::dex_aftermath::get_aftermath_module())
    }

    fun is_approved_intermediate_token<T0>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0));
        let v2 = b"wUSDC";
        if (v1 == &v2) {
            true
        } else {
            let v4 = b"USDT";
            if (v1 == &v4) {
                true
            } else {
                let v5 = b"BUCK";
                v1 == &v5
            }
        }
    }

    public fun validate_atomic_execution_ready(arg0: u64, arg1: bool, arg2: bool) : bool {
        if (arg0 >= 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount()) {
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
        arg0 == 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount() && is_approved_intermediate_token<T0>()
    }

    public fun validate_simple_pattern_compliance<T0>(arg0: u64, arg1: bool, arg2: bool) : bool {
        if (arg0 == 0xca056c17b9e453c65747c5c9756d742558d62bdd00e27c25814b0724c8d1a4af::constants::sui_input_amount()) {
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
        let v2 = b"wUSDC";
        let v3 = b"USDT";
        let v4 = b"BUCK";
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

