module 0x438cf466a7beada9e4f2643e25503890e07e8464d140994728ab6048b31cd4ea::gas_optimized_arbitrage {
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

    public fun calculate_sponsor_gas_estimate(arg0: u8, arg1: u8, arg2: u64) : u64 {
        let v0 = estimate_ptb_gas_cost(arg0, arg1);
        v0 + v0 * arg2 / 100
    }

    public entry fun create_sponsor_profile(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SponsorProfile{
            id                     : 0x2::object::new(arg1),
            sponsor_address        : v0,
            gas_budget_limit       : arg0,
            transactions_sponsored : 0,
            total_gas_spent        : 0,
            is_active              : true,
        };
        0x2::transfer::public_transfer<SponsorProfile>(v1, v0);
    }

    public entry fun create_sponsor_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SponsorRegistry{
            id                           : 0x2::object::new(arg0),
            authorized_sponsors          : 0x1::vector::empty<address>(),
            total_sponsored_transactions : 0,
            total_gas_spent              : 0,
        };
        0x2::transfer::share_object<SponsorRegistry>(v0);
    }

    public entry fun deactivate_sponsor_profile(arg0: &mut SponsorProfile, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sponsor_address == 0x2::tx_context::sender(arg1), 8);
        arg0.is_active = false;
    }

    public fun estimate_ptb_gas_cost(arg0: u8, arg1: u8) : u64 {
        50000 + get_dex_gas_cost(arg0) + get_dex_gas_cost(arg1)
    }

    public fun estimate_sponsor_costs(arg0: u8, arg1: u8, arg2: u64, arg3: u64) : u64 {
        calculate_sponsor_gas_estimate(arg0, arg1, arg3) * arg2
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

    public entry fun generate_sponsored_arbitrage_params<T0>(arg0: address, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg0 != v0, 6);
        assert!(arg1 <= 5 && arg2 <= 5, 3);
        assert!(arg1 != arg2, 4);
        assert!(arg5 >= 100000, 2);
        assert!(arg7 >= 500000, 1);
        let (v1, v2) = get_dex_info(arg1);
        let (v3, v4) = get_dex_info(arg2);
        SponsoredArbitrageParams{user: v0, sponsor: arg0, dex_a: arg1, dex_b: arg2, dex_a_package: v1, dex_b_package: v3, dex_a_function: v2, dex_b_function: v4, pool_a_id: arg3, pool_b_id: arg4, input_amount: 10000000, min_profit: arg5, deadline: arg6, sponsor_gas_budget: arg7};
        let v5 = SponsoredArbitrageEvent{
            user               : v0,
            sponsor            : arg0,
            dex_a              : arg1,
            dex_b              : arg2,
            dex_a_package      : v1,
            dex_b_package      : v3,
            input_amount       : 10000000,
            expected_profit    : arg5,
            sponsor_gas_budget : arg7,
            timestamp          : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<SponsoredArbitrageEvent>(v5);
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

    public fun get_sponsor_profile_info(arg0: &SponsorProfile) : (address, u64, u64, u64, bool) {
        (arg0.sponsor_address, arg0.gas_budget_limit, arg0.transactions_sponsored, arg0.total_gas_spent, arg0.is_active)
    }

    public fun get_sponsored_arbitrage_params<T0>(arg0: address, arg1: address, arg2: u8, arg3: u8, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64) : SponsoredArbitrageParams {
        let (v0, v1) = get_dex_info(arg2);
        let (v2, v3) = get_dex_info(arg3);
        SponsoredArbitrageParams{
            user               : arg0,
            sponsor            : arg1,
            dex_a              : arg2,
            dex_b              : arg3,
            dex_a_package      : v0,
            dex_b_package      : v2,
            dex_a_function     : v1,
            dex_b_function     : v3,
            pool_a_id          : arg4,
            pool_b_id          : arg5,
            input_amount       : 10000000,
            min_profit         : arg6,
            deadline           : arg7,
            sponsor_gas_budget : arg8,
        }
    }

    public fun get_turbos_params<T0>(arg0: u64, arg1: u64, arg2: 0x2::object::ID, arg3: u64) : (address, 0x1::string::String, 0x2::object::ID, u64, u64, u128, bool, u64) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, 0x1::string::utf8(b"swap_a_b"), arg2, arg0, arg1, 4295048016, true, arg3)
    }

    public fun is_gas_optimized(arg0: u8, arg1: u8) : bool {
        estimate_ptb_gas_cost(arg0, arg1) <= 500000
    }

    public entry fun reactivate_sponsor_profile(arg0: &mut SponsorProfile, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sponsor_address == 0x2::tx_context::sender(arg1), 8);
        arg0.is_active = true;
    }

    public entry fun update_sponsor_profile(arg0: &mut SponsorProfile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sponsor_address == 0x2::tx_context::sender(arg2), 8);
        arg0.transactions_sponsored = arg0.transactions_sponsored + 1;
        arg0.total_gas_spent = arg0.total_gas_spent + arg1;
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

    public fun validate_sponsor_authorization(arg0: address, arg1: u64, arg2: &SponsorProfile) : bool {
        if (arg2.sponsor_address != arg0) {
            return false
        };
        if (!arg2.is_active) {
            return false
        };
        if (arg1 > arg2.gas_budget_limit) {
            return false
        };
        true
    }

    public fun validate_sponsored_claude_compliance(arg0: address, arg1: address, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64) : bool {
        if (arg0 == arg1) {
            return false
        };
        if (arg2 != 10000000) {
            return false
        };
        if (arg3 == arg4) {
            return false
        };
        if (arg3 > 5 || arg4 > 5) {
            return false
        };
        if (arg5 < 100000) {
            return false
        };
        if (arg6 < 500000) {
            return false
        };
        true
    }

    // decompiled from Move bytecode v6
}

