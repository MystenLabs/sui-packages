module 0x9661effdf6238bbe3525851c9d903b9c97e41f382762415f1407ccee0275e5b2::dex_cetus {
    public fun build_swap_params(arg0: u64, arg1: bool) : (address, address, address, bool, bool, u64, u64, u128) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, arg1, true, arg0, 0, 79226673515401279992447579055)
    }

    public fun cetus_clmm_swap_a2b_call(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        abort 999
    }

    public fun get_confirmed_pool() : address {
        @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public fun get_global_config() : address {
        @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f
    }

    public fun get_package() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun get_sqrt_price_limit() : u128 {
        79226673515401279992447579055
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 600);
        cetus_clmm_swap_a2b_call(arg0, v0, arg2, arg3);
    }

    public fun validate_cetus_swap(arg0: u64, arg1: u128) : bool {
        arg0 > 0 && arg1 > 0
    }

    // decompiled from Move bytecode v6
}

