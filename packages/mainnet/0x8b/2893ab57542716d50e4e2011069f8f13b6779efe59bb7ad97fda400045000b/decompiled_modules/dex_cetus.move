module 0x8b2893ab57542716d50e4e2011069f8f13b6779efe59bb7ad97fda400045000b::dex_cetus {
    struct CetusSwapExecuted has copy, drop {
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
        is_b2a: bool,
        sender: address,
    }

    public fun swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 502);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::zero<T1>(arg4);
        let (v3, v4) = cetus_pool_script_swap<T0, T1>(arg3, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, arg0, v2, arg2, true, v0, arg1, 79226673515401279992447579055, arg4);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::value<T1>(&v6);
        assert!(v7 >= arg1, 503);
        let v8 = CetusSwapExecuted{
            pool_id    : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            amount_in  : v0,
            amount_out : v7,
            is_b2a     : arg2,
            sender     : v1,
        };
        0x2::event::emit<CetusSwapExecuted>(v8);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        v6
    }

    fun cetus_pool_script_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        abort 504
    }

    public fun get_cetus_config() : (address, address, address, address) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630)
    }

    public entry fun swap_tokens<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 502);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::zero<T1>(arg4);
        let (v3, v4) = cetus_pool_script_swap<T0, T1>(arg3, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, arg0, v2, arg2, true, v0, arg1, 79226673515401279992447579055, arg4);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::value<T1>(&v6);
        assert!(v7 >= arg1, 503);
        let v8 = CetusSwapExecuted{
            pool_id    : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            amount_in  : v0,
            amount_out : v7,
            is_b2a     : arg2,
            sender     : v1,
        };
        0x2::event::emit<CetusSwapExecuted>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, v1);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
    }

    public entry fun test_cetus_config(arg0: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, v3) = get_cetus_config();
        let v4 = CetusSwapExecuted{
            pool_id    : v3,
            amount_in  : 0,
            amount_out : 0,
            is_b2a     : true,
            sender     : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<CetusSwapExecuted>(v4);
    }

    // decompiled from Move bytecode v6
}

