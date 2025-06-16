module 0x86885d4dce5f4ef8ac7e7c38ca689b31b97737ae4eb42314fd7b9f4b8231219b::dex_cetus {
    public fun get_cetus_config() : address {
        @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f
    }

    public fun get_cetus_package() : address {
        @0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be
    }

    public fun get_cetus_pool() : address {
        0x86885d4dce5f4ef8ac7e7c38ca689b31b97737ae4eb42314fd7b9f4b8231219b::constants::cetus_sui_usdc_pool()
    }

    public fun get_sqrt_price_limit() : u128 {
        79226673515401279992447579055
    }

    public fun prepare_swap_transaction<T0, T1>(arg0: u64, arg1: address, arg2: u64, arg3: bool) : bool {
        if (arg0 > 0) {
            if (arg1 != @0x0) {
                arg2 >= 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 600);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun validate_cetus_swap(arg0: u64, arg1: u128) : bool {
        arg0 > 0 && arg1 > 0
    }

    // decompiled from Move bytecode v6
}

