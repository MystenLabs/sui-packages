module 0x7cec41d195dab2ae5c847cf1c5339b349679d2948615b766ca608eee7e28f8e9::router {
    struct SwapExecuted has copy, drop {
        dex: u8,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        sender: address,
    }

    struct FlashSwapExecuted has copy, drop {
        dex: u8,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        sender: address,
    }

    public fun dex_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Cetus")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Bluefin")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Turbos")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    public fun flash_swap<T0, T1>(arg0: u8, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(arg1 > 0, 1);
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0, 3);
        let v1 = FlashSwapExecuted{
            dex        : arg0,
            token_in   : 0x1::type_name::with_defining_ids<T0>(),
            token_out  : 0x1::type_name::with_defining_ids<T1>(),
            amount_in  : arg1,
            amount_out : 0,
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FlashSwapExecuted>(v1);
        (0x2::coin::zero<T0>(arg3), 0x2::coin::zero<T1>(arg3), 0)
    }

    public fun swap_a2b<T0, T1>(arg0: u8, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v1, 3);
        let v2 = SwapExecuted{
            dex        : arg0,
            token_in   : 0x1::type_name::with_defining_ids<T0>(),
            token_out  : 0x1::type_name::with_defining_ids<T1>(),
            amount_in  : v0,
            amount_out : 0,
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg3)
    }

    public fun swap_b2a<T0, T1>(arg0: u8, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v1, 3);
        let v2 = SwapExecuted{
            dex        : arg0,
            token_in   : 0x1::type_name::with_defining_ids<T1>(),
            token_out  : 0x1::type_name::with_defining_ids<T0>(),
            amount_in  : v0,
            amount_out : 0,
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::destroy_zero<T1>(arg1);
        0x2::coin::zero<T0>(arg3)
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

