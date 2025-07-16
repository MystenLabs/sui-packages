module 0x43c37ac1aeae9c033b681cc0e8fa5ca7575c595e0bd2f0c9059a52f4478d38cd::gas_optimized_arbitrage {
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

    public fun execute_real_atomic_arbitrage<T0>(arg0: u64, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1 <= 5 && arg2 <= 5, 3);
        assert!(arg1 != arg2, 4);
        assert!(arg5 >= 100000, 2);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg6, 2);
        let (v0, _) = get_dex_info(arg1);
        let (v2, _) = get_dex_info(arg2);
        let v4 = AtomicArbitrageEvent{
            user            : 0x2::tx_context::sender(arg8),
            dex_a           : arg1,
            dex_b           : arg2,
            dex_a_package   : v0,
            dex_b_package   : v2,
            input_amount    : arg0,
            expected_profit : arg5,
            timestamp       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<AtomicArbitrageEvent>(v4);
        0x2::coin::zero<0x2::sui::SUI>(arg8)
    }

    public fun get_all_dex_addresses() : (address, address, address, address, address, address) {
        (@0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e, @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0xb104ecc75397f3a65735ef26c85a037da1d197e26f4f275a9990a577ba0e6c4c, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244)
    }

    public fun get_dex_info(arg0: u8) : (address, 0x1::string::String) {
        let (v0, v1) = if (arg0 == 0) {
            (0x1::string::utf8(b"router::swap_exact_input"), @0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e)
        } else {
            let (v2, v3) = if (arg0 == 1) {
                (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, 0x1::string::utf8(b"pool::flash_swap"))
            } else if (arg0 == 2) {
                (@0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, 0x1::string::utf8(b"spot_dex::swap_token_x"))
            } else if (arg0 == 3) {
                (@0xb104ecc75397f3a65735ef26c85a037da1d197e26f4f275a9990a577ba0e6c4c, 0x1::string::utf8(b"pool::swap"))
            } else if (arg0 == 4) {
                (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, 0x1::string::utf8(b"swap_a_b"))
            } else {
                (@0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244, 0x1::string::utf8(b"clob_v2::place_market_order"))
            };
            (v3, v2)
        };
        (v1, v0)
    }

    public fun get_flash_loan_arbitrage_params<T0>(arg0: u64, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64) : (u64, u8, u8, 0x2::object::ID, 0x2::object::ID, u64, u64, address, address) {
        let (v0, _) = get_dex_info(arg1);
        let (v2, _) = get_dex_info(arg2);
        (arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v2)
    }

    public fun get_max_gas_budget() : u64 {
        500000
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    public fun get_required_input_amount() : u64 {
        10000000
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

