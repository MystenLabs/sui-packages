module 0x600b953edb5a9c5da3252621d887d31c8cb3e6eeb31cff4cd8cbcb7fe0b839f7::dex_cetus {
    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        trader: address,
        pool_address: address,
    }

    public fun swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 - v0 * 30 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        let v2 = SwapExecuted{
            dex_name     : b"Cetus",
            amount_in    : v0,
            amount_out   : v1,
            trader       : arg1,
            pool_address : @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg2)
    }

    public fun swap_cross<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0x600b953edb5a9c5da3252621d887d31c8cb3e6eeb31cff4cd8cbcb7fe0b839f7::constants::get_zero_amount_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
        let v1 = SwapExecuted{
            dex_name     : b"Cetus-Cross",
            amount_in    : v0,
            amount_out   : v0 - v0 * 30 / 10000,
            trader       : arg1,
            pool_address : 0x600b953edb5a9c5da3252621d887d31c8cb3e6eeb31cff4cd8cbcb7fe0b839f7::constants::get_cetus_sui_usdc_pool(),
        };
        0x2::event::emit<SwapExecuted>(v1);
        abort 0x600b953edb5a9c5da3252621d887d31c8cb3e6eeb31cff4cd8cbcb7fe0b839f7::constants::get_zero_amount_error()
    }

    public fun swap_generic<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 - v0 * 30 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
        let v2 = SwapExecuted{
            dex_name     : b"Cetus",
            amount_in    : v0,
            amount_out   : v1,
            trader       : arg1,
            pool_address : @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::split<T0>(&mut arg0, v1, arg2)
    }

    // decompiled from Move bytecode v6
}

