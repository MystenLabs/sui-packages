module 0xcddaa2147a45108af6804fdcb17b1dd9848005b72f1865e0091800826b47326c::dex_cetus {
    public fun calculate_expected_output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 - arg0 * arg1 / 1000000;
        v0 - v0 * arg2 / 1000000
    }

    public fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            1000
        }
    }

    public fun cetus_atomic_arbitrage_params<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u128, u128, bool, bool) {
        assert!(arg0 == 10000000, 4);
        (arg0, arg0 + arg1, get_default_sqrt_price_limit(true), get_default_sqrt_price_limit(false), true, true)
    }

    public fun cetus_flash_swap_sui_for_token<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u128, bool, bool) {
        assert!(arg0 >= 1000, 1);
        assert!(arg0 == 10000000, 4);
        (arg0, arg1, get_default_sqrt_price_limit(true), true, true)
    }

    public fun cetus_flash_swap_token_for_sui<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u128, bool, bool) {
        assert!(arg0 >= 1000, 1);
        (arg0, arg1, get_default_sqrt_price_limit(false), true, true)
    }

    public fun estimate_flash_swap_gas() : u64 {
        15000000
    }

    public fun get_cetus_constants() : (u128, u128, u64, address, address) {
        (4295128739, 79226673515401279992447579055, 1000, @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f)
    }

    public fun get_cetus_fee_rate() : u64 {
        3000
    }

    public fun get_cetus_flash_swap_params(arg0: u64, arg1: bool, arg2: u128) : (u64, bool, bool, u128) {
        (arg0, arg1, true, arg2)
    }

    public fun get_cetus_flash_swap_target() : vector<u8> {
        b"pool::flash_swap"
    }

    public fun get_cetus_global_config() : address {
        @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f
    }

    public fun get_cetus_package() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun get_cetus_repay_flash_swap_target() : vector<u8> {
        b"pool::repay_flash_swap"
    }

    public fun get_default_sqrt_price_limit(arg0: bool) : u128 {
        if (arg0) {
            4295128739 + 1
        } else {
            79226673515401279992447579055 - 1
        }
    }

    public fun is_valid_pool_id(arg0: 0x2::object::ID) : bool {
        0x2::object::id_to_address(&arg0) != @0x0
    }

    public fun validate_claude_compliance(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 != 10000000) {
            return false
        };
        if (arg1 <= arg0) {
            return false
        };
        arg1 - arg0 >= arg2
    }

    // decompiled from Move bytecode v6
}

