module 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_turbos {
    public fun calculate_deadline(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 * 1000
    }

    public fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            1000
        }
    }

    public fun estimate_output_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 1000000
    }

    public fun get_default_fee_rate() : u64 {
        3000
    }

    public fun get_default_slippage_bps() : u64 {
        100
    }

    public fun get_default_sqrt_price_limits(arg0: bool) : u128 {
        if (arg0) {
            4295048016
        } else {
            79226673515401279992447579055
        }
    }

    public fun get_min_amount() : u64 {
        1000
    }

    public fun get_sqrt_price_range() : (u128, u128) {
        (4295048016, 79226673515401279992447579055)
    }

    public fun get_swap_target(arg0: bool) : vector<u8> {
        if (arg0) {
            get_turbos_swap_a_b_target()
        } else {
            get_turbos_swap_b_a_target()
        }
    }

    public fun get_turbos_constants() : (address, u64, u64, u64) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, 1000, 100, 3000)
    }

    public fun get_turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_turbos_swap_a_b_target() : vector<u8> {
        b"swap_a_b"
    }

    public fun get_turbos_swap_b_a_target() : vector<u8> {
        b"swap_b_a"
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

    public fun is_valid_sqrt_price_limit(arg0: u128) : bool {
        arg0 >= 4295048016 && arg0 <= 79226673515401279992447579055
    }

    public fun turbos_atomic_arbitrage_params<T0>(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, u128, u128, bool, bool, u64) {
        assert!(arg0 == 10000000, 4);
        (arg0, arg0 + arg1, arg2, arg3, true, true, arg4)
    }

    public fun turbos_swap_exact_sui_for_token<T0>(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u128, bool, u64) {
        assert!(arg0 >= 1000, 1);
        assert!(arg0 == 10000000, 4);
        (arg0, arg1, arg2, true, arg3)
    }

    public fun turbos_swap_exact_token_for_sui<T0>(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u128, bool, u64) {
        assert!(arg0 >= 1000, 1);
        (arg0, arg1, arg2, true, arg3)
    }

    // decompiled from Move bytecode v6
}

