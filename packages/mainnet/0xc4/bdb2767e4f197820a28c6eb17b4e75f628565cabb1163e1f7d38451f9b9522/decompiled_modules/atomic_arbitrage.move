module 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::atomic_arbitrage {
    public entry fun arb_aftermath_bluefin<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 0);
        0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_aftermath::swap_sui_to_wusdc(0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3), arg1, 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::constants::min_output_amount(), arg3);
    }

    public entry fun arb_cetus_turbos<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::constants::sui_input_amount();
        0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::constants::min_output_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_flash_turbos_deepbook<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun arb_kriya_turbos<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::constants::sui_input_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun arb_optimized_aftermath_bluefin<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun arb_optimized_kriya_turbos<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg0);
    }

    public entry fun arb_turbos_deepbook<T0>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::constants::sui_input_amount();
        let v1 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::constants::min_output_amount();
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook::swap_wusdc_to_sui<T0>(0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::swap_sui_to_wusdc<T0>(0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::coin_helpers::split_coin<0x2::sui::SUI>(arg0, v0, arg3), arg1, v1, arg3), arg2, v1, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun check_alternative_token_compatibility<T0>() : (bool, bool, bool) {
        let v0 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_kriya::check_token_compatibility() && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::check_token_compatibility();
        let v1 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_aftermath::check_token_compatibility() && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_bluefin::check_token_compatibility();
        let v2 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::check_token_compatibility() && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook::check_token_compatibility();
        (v0, v1, v2)
    }

    public fun check_alternative_wusdc_support() : (bool, bool, bool) {
        let v0 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::supports_wusdc() && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_kriya::supports_wusdc();
        let v1 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_aftermath::supports_wusdc() && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_bluefin::supports_wusdc();
        let v2 = 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::supports_wusdc() && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook::supports_wusdc();
        (v0, v1, v2)
    }

    public fun check_token_compatibility<T0>() : bool {
        0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::check_token_compatibility() && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook::check_token_compatibility()
    }

    public fun check_wusdc_support() : bool {
        0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::supports_wusdc() && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook::supports_wusdc()
    }

    public fun get_aftermath_bluefin_addresses() : (address, address) {
        (0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_aftermath::get_sui_wusdc_router(), 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_bluefin::get_sui_wusdc_pool())
    }

    public fun get_gas_efficient_patterns() : vector<bool> {
        let (v0, v1, v2, v3) = get_pattern_gas_estimates();
        let v4 = 3000000;
        let v5 = 0x1::vector::empty<bool>();
        let v6 = &mut v5;
        0x1::vector::push_back<bool>(v6, v0 < v4);
        0x1::vector::push_back<bool>(v6, v1 < v4);
        0x1::vector::push_back<bool>(v6, v2 < v4);
        0x1::vector::push_back<bool>(v6, v3 < v4);
        v5
    }

    public fun get_kriya_turbos_addresses() : (address, address) {
        (0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_kriya::get_sui_wusdc_pool(), 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::get_sui_wusdc_pool())
    }

    public fun get_pattern_gas_estimates() : (u64, u64, u64, u64) {
        (1800000, 1600000, 1800000, 1400000)
    }

    public fun get_recommended_pattern() : u8 {
        2
    }

    public fun get_required_addresses() : (address, address) {
        (0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::get_sui_wusdc_pool(), 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook::get_sui_wusdc_pool())
    }

    public fun get_turbos_deepbook_addresses() : (address, address) {
        (0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::get_sui_wusdc_pool(), 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook::get_sui_wusdc_pool())
    }

    public fun validate_aftermath_bluefin_setup(arg0: address, arg1: address) : bool {
        0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_aftermath::validate_pool(arg0) && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_bluefin::validate_pool(arg1)
    }

    public fun validate_kriya_turbos_setup(arg0: address, arg1: address) : bool {
        0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_kriya::validate_pool(arg0) && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::validate_pool(arg1)
    }

    public fun validate_turbos_deepbook_setup(arg0: address, arg1: address) : bool {
        0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_turbos::validate_pool(arg0) && 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_deepbook::validate_pool(arg1)
    }

    // decompiled from Move bytecode v6
}

