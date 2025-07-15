module 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_kriya {
    public fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            1000
        }
    }

    public fun get_default_slippage_bps() : u64 {
        100
    }

    public fun get_kriya_constants() : (address, u64, u64) {
        (@0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, 1000, 100)
    }

    public fun get_kriya_package() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun get_kriya_swap_token_x_target() : vector<u8> {
        b"spot_dex::swap_token_x"
    }

    public fun get_kriya_swap_token_y_target() : vector<u8> {
        b"spot_dex::swap_token_y"
    }

    public fun get_min_amount() : u64 {
        1000
    }

    public fun get_swap_target(arg0: bool) : vector<u8> {
        if (arg0) {
            get_kriya_swap_token_x_target()
        } else {
            get_kriya_swap_token_y_target()
        }
    }

    public fun is_claude_compliant_amount(arg0: u64) : bool {
        arg0 == 10000000
    }

    public fun is_valid_amount(arg0: u64) : bool {
        arg0 >= 1000
    }

    public fun is_valid_pool_id(arg0: 0x2::object::ID) : bool {
        0x2::object::id_to_address(&arg0) != @0x0
    }

    public fun kriya_atomic_arbitrage_params<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, bool) {
        assert!(arg0 == 10000000, 4);
        (arg0, arg0 + arg1, true, false)
    }

    public fun kriya_swap_exact_sui_for_token<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, bool) {
        assert!(arg0 >= 1000, 1);
        assert!(arg0 == 10000000, 4);
        (arg0, arg1, true)
    }

    public fun kriya_swap_exact_token_for_sui<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, bool) {
        assert!(arg0 >= 1000, 1);
        (arg0, arg1, false)
    }

    // decompiled from Move bytecode v6
}

