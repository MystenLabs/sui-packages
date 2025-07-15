module 0xcddaa2147a45108af6804fdcb17b1dd9848005b72f1865e0091800826b47326c::dex_bluefin {
    public fun bluefin_atomic_arbitrage_params<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u128, u128) {
        assert!(arg0 == 10000000, 4);
        (arg0, arg0 + arg1, get_default_sqrt_price_limit(true), get_default_sqrt_price_limit(false))
    }

    public fun bluefin_swap_exact_sui_for_token<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u128) {
        assert!(arg0 >= 1000, 1);
        assert!(arg0 == 10000000, 4);
        (arg0, arg1, get_default_sqrt_price_limit(true))
    }

    public fun bluefin_swap_exact_token_for_sui<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u128) {
        assert!(arg0 >= 1000, 1);
        (arg0, arg1, get_default_sqrt_price_limit(false))
    }

    public fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            1000
        }
    }

    public fun get_bluefin_constants() : (u128, u128, u64, address, address) {
        (4295048016, 79226673515401279992447579055, 1000, @0xb104ecc75397f3a65735ef26c85a037da1d197e26f4f275a9990a577ba0e6c4c, @0x9774e359588ead122af1c7e7f64e14ade261cfeecdb5d0eb4a5b41b01fb3c7)
    }

    public fun get_bluefin_global_config() : address {
        @0x9774e359588ead122af1c7e7f64e14ade261cfeecdb5d0eb4a5b41b01fb3c7
    }

    public fun get_bluefin_package() : address {
        @0xb104ecc75397f3a65735ef26c85a037da1d197e26f4f275a9990a577ba0e6c4c
    }

    public fun get_bluefin_swap_target() : vector<u8> {
        b"pool::swap"
    }

    public fun get_default_sqrt_price_limit(arg0: bool) : u128 {
        if (arg0) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        }
    }

    public fun is_valid_pool_id(arg0: 0x2::object::ID) : bool {
        0x2::object::id_to_address(&arg0) != @0x0
    }

    // decompiled from Move bytecode v6
}

