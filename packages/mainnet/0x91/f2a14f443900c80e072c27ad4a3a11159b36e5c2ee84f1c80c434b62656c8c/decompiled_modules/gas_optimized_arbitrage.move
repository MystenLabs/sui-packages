module 0x91f2a14f443900c80e072c27ad4a3a11159b36e5c2ee84f1c80c434b62656c8c::gas_optimized_arbitrage {
    struct ArbitrageParams has copy, drop {
        dex_a: u8,
        dex_b: u8,
        dex_a_package: address,
        dex_b_package: address,
        dex_a_function: 0x1::string::String,
        dex_b_function: 0x1::string::String,
        pool_a_id: 0x2::object::ID,
        pool_b_id: 0x2::object::ID,
        input_amount: u64,
        min_profit: u64,
        deadline: u64,
    }

    struct AtomicArbitrageEvent has copy, drop {
        user: address,
        dex_a: u8,
        dex_b: u8,
        dex_a_package: address,
        dex_b_package: address,
        input_amount: u64,
        expected_profit: u64,
        timestamp: u64,
    }

    struct SponsoredArbitrageParams has copy, drop {
        user: address,
        sponsor: address,
        dex_a: u8,
        dex_b: u8,
        dex_a_package: address,
        dex_b_package: address,
        dex_a_function: 0x1::string::String,
        dex_b_function: 0x1::string::String,
        pool_a_id: 0x2::object::ID,
        pool_b_id: 0x2::object::ID,
        input_amount: u64,
        min_profit: u64,
        deadline: u64,
        sponsor_gas_budget: u64,
    }

    struct SponsoredArbitrageEvent has copy, drop {
        user: address,
        sponsor: address,
        dex_a: u8,
        dex_b: u8,
        dex_a_package: address,
        dex_b_package: address,
        input_amount: u64,
        expected_profit: u64,
        sponsor_gas_budget: u64,
        timestamp: u64,
    }

    struct SponsorRegistry has store, key {
        id: 0x2::object::UID,
        authorized_sponsors: vector<address>,
        total_sponsored_transactions: u64,
        total_gas_spent: u64,
    }

    struct SponsorProfile has store, key {
        id: 0x2::object::UID,
        sponsor_address: address,
        gas_budget_limit: u64,
        transactions_sponsored: u64,
        total_gas_spent: u64,
        is_active: bool,
    }

    public fun estimate_ptb_gas_cost(arg0: u8, arg1: u8) : u64 {
        50000 + get_dex_gas_cost(arg0) + get_dex_gas_cost(arg1)
    }

    public entry fun generate_arbitrage_params<T0>(arg0: u8, arg1: u8, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 5 && arg1 <= 5, 3);
        assert!(arg0 != arg1, 4);
        assert!(arg4 >= 100000, 2);
        let (v0, v1) = get_dex_info(arg0);
        let (v2, v3) = get_dex_info(arg1);
        ArbitrageParams{dex_a: arg0, dex_b: arg1, dex_a_package: v0, dex_b_package: v2, dex_a_function: v1, dex_b_function: v3, pool_a_id: arg2, pool_b_id: arg3, input_amount: 10000000, min_profit: arg4, deadline: arg5};
        let v4 = AtomicArbitrageEvent{
            user            : 0x2::tx_context::sender(arg7),
            dex_a           : arg0,
            dex_b           : arg1,
            dex_a_package   : v0,
            dex_b_package   : v2,
            input_amount    : 10000000,
            expected_profit : arg4,
            timestamp       : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<AtomicArbitrageEvent>(v4);
    }

    public fun get_aftermath_params<T0>(arg0: u64, arg1: u64, arg2: 0x2::object::ID, arg3: u64) : (address, 0x1::string::String, 0x2::object::ID, u64, u64, u64) {
        (@0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e, 0x1::string::utf8(b"router::swap_exact_input"), arg2, arg0, arg1, arg3)
    }

    public fun get_all_dex_addresses() : (address, address, address, address, address, address) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0xb104ecc75397f3a65735ef26c85a037da1d197e26f4f275a9990a577ba0e6c4c, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, @0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244)
    }

    public fun get_bluefin_params<T0>(arg0: u64, arg1: u64, arg2: 0x2::object::ID) : (address, 0x1::string::String, 0x2::object::ID, u64, u64, u128) {
        (@0xb104ecc75397f3a65735ef26c85a037da1d197e26f4f275a9990a577ba0e6c4c, 0x1::string::utf8(b"pool::swap"), arg2, arg0, arg1, 4295048017)
    }

    public fun get_cetus_params<T0>(arg0: u64, arg1: u64, arg2: 0x2::object::ID) : (address, address, 0x1::string::String, 0x2::object::ID, u64, u64, u128, bool, bool) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, 0x1::string::utf8(b"pool::flash_swap"), arg2, arg0, arg1, 4295128740, true, true)
    }

    public fun get_deepbook_params<T0>(arg0: u64, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64) : (address, 0x1::string::String, 0x2::object::ID, u64, u64, u64, u64, bool) {
        (@0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244, 0x1::string::utf8(b"clob_v2::place_market_order"), arg2, arg0, arg1, arg3, arg4, true)
    }

    fun get_dex_gas_cost(arg0: u8) : u64 {
        if (arg0 == 0) {
            200000
        } else if (arg0 == 1) {
            120000
        } else if (arg0 == 2) {
            180000
        } else if (arg0 == 3) {
            160000
        } else if (arg0 == 4) {
            150000
        } else {
            140000
        }
    }

    public fun get_dex_info(arg0: u8) : (address, 0x1::string::String) {
        let (v0, v1) = if (arg0 == 0) {
            (0x1::string::utf8(b"pool::flash_swap"), @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb)
        } else {
            let (v2, v3) = if (arg0 == 1) {
                (@0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, 0x1::string::utf8(b"spot_dex::swap_token_x"))
            } else if (arg0 == 2) {
                (@0xb104ecc75397f3a65735ef26c85a037da1d197e26f4f275a9990a577ba0e6c4c, 0x1::string::utf8(b"pool::swap"))
            } else if (arg0 == 3) {
                (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, 0x1::string::utf8(b"swap_a_b"))
            } else if (arg0 == 4) {
                (@0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e, 0x1::string::utf8(b"router::swap_exact_input"))
            } else {
                (@0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244, 0x1::string::utf8(b"clob_v2::place_market_order"))
            };
            (v3, v2)
        };
        (v1, v0)
    }

    public fun get_dex_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Cetus")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Kriya")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Bluefin")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Turbos")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Aftermath")
        } else {
            0x1::string::utf8(b"DeepBook")
        }
    }

    public fun get_kriya_params<T0>(arg0: u64, arg1: u64, arg2: 0x2::object::ID) : (address, 0x1::string::String, 0x2::object::ID, u64, u64, bool) {
        (@0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, 0x1::string::utf8(b"spot_dex::swap_token_x"), arg2, arg0, arg1, true)
    }

    public fun get_max_gas_budget() : u64 {
        500000
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    public fun get_optimal_dex_pair() : (u8, u8) {
        (1, 5)
    }

    public fun get_required_input_amount() : u64 {
        10000000
    }

    public fun get_turbos_params<T0>(arg0: u64, arg1: u64, arg2: 0x2::object::ID, arg3: u64) : (address, 0x1::string::String, 0x2::object::ID, u64, u64, u128, bool, u64) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, 0x1::string::utf8(b"swap_a_b"), arg2, arg0, arg1, 4295048016, true, arg3)
    }

    public fun is_gas_optimized(arg0: u8, arg1: u8) : bool {
        estimate_ptb_gas_cost(arg0, arg1) <= 500000
    }

    public fun validate_claude_compliance(arg0: u64, arg1: u8, arg2: u8, arg3: u64) : bool {
        if (arg0 != 10000000) {
            return false
        };
        if (arg1 == arg2) {
            return false
        };
        if (arg1 > 5 || arg2 > 5) {
            return false
        };
        arg3 >= 100000
    }

    // decompiled from Move bytecode v6
}

