module 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_deepbook {
    public fun calculate_deadline(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 * 1000
    }

    public fun calculate_market_price(arg0: bool) : u64 {
        if (arg0) {
            999999999999
        } else {
            1
        }
    }

    public fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            1000
        }
    }

    public fun deepbook_atomic_arbitrage_params<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, bool, bool) {
        assert!(arg0 == 10000000, 4);
        (arg0, arg0 + arg1, arg2, arg3, arg4, true, false)
    }

    public fun deepbook_swap_exact_sui_for_token<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, bool) {
        assert!(arg0 >= 1000, 1);
        assert!(arg0 == 10000000, 4);
        (arg0, arg1, arg2, arg3, true)
    }

    public fun deepbook_swap_exact_token_for_sui<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, bool) {
        assert!(arg0 >= 1000, 1);
        (arg0, arg1, arg2, arg3, false)
    }

    public fun estimate_output_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 10000
    }

    public fun generate_client_order_id(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun get_deepbook_constants() : (address, address, u64, u64, u64) {
        (@0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244, @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d, 1000, 100, 25)
    }

    public fun get_deepbook_market_order_target() : vector<u8> {
        b"clob_v2::place_market_order"
    }

    public fun get_deepbook_package() : address {
        @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244
    }

    public fun get_deepbook_registry() : address {
        @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d
    }

    public fun get_deepbook_swap_base_target() : vector<u8> {
        b"clob_v2::swap_exact_base_for_quote"
    }

    public fun get_deepbook_swap_quote_target() : vector<u8> {
        b"clob_v2::swap_exact_quote_for_base"
    }

    public fun get_default_fee_rate() : u64 {
        25
    }

    public fun get_default_slippage_bps() : u64 {
        100
    }

    public fun get_min_amount() : u64 {
        1000
    }

    public fun get_min_sizes() : (u64, u64) {
        (1, 1)
    }

    public fun get_swap_target(arg0: bool) : vector<u8> {
        if (arg0) {
            get_deepbook_swap_base_target()
        } else {
            get_deepbook_swap_quote_target()
        }
    }

    public fun is_claude_compliant_amount(arg0: u64) : bool {
        arg0 == 10000000
    }

    public fun is_valid_amount(arg0: u64) : bool {
        arg0 >= 1000
    }

    public fun is_valid_deadline(arg0: u64, arg1: u64) : bool {
        arg0 > arg1
    }

    public fun is_valid_lot_size(arg0: u64) : bool {
        arg0 >= 1
    }

    public fun is_valid_pool_id(arg0: 0x2::object::ID) : bool {
        0x2::object::id_to_address(&arg0) != @0x0
    }

    public fun is_valid_tick_size(arg0: u64) : bool {
        arg0 >= 1
    }

    // decompiled from Move bytecode v6
}

