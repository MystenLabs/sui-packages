module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_v2_real {
    struct RealBluefinV2SwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        is_exact_in: bool,
        is_token_0: bool,
        success: bool,
    }

    public fun get_bluefin_v2_pools() : (address, address, address) {
        (@0xe809689d7997a69b3d2596f7f2c5ab4069fd9b33030f79e0b30556b04e1c883, @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29, @0xde705d4f3ded922b729d9b923be08e1391dd4caeff8496326123934d0fb1c312)
    }

    public fun is_bluefin_v2_ready() : bool {
        false
    }

    public fun swap_simple<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg4);
        swap_v2_real<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg1), arg2, 0, true, true, v0, 0x2::clock::timestamp_ms(arg3) + 300000, arg3, arg4)
    }

    public fun swap_v2_real<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: bool, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 502);
        assert!(v0 == arg2, 502);
        let v1 = if (arg0 == @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29) {
            25
        } else if (arg0 == @0xde705d4f3ded922b729d9b923be08e1391dd4caeff8496326123934d0fb1c312) {
            100
        } else {
            30
        };
        let v2 = v0 - v0 * v1 / 10000;
        if (arg5 && arg3 > 0) {
            assert!(v2 >= arg3, 503);
        };
        let v3 = RealBluefinV2SwapExecuted{
            pool        : arg0,
            amount_in   : v0,
            amount_out  : v2,
            is_exact_in : arg5,
            is_token_0  : arg6,
            success     : false,
        };
        0x2::event::emit<RealBluefinV2SwapExecuted>(v3);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg10)
    }

    // decompiled from Move bytecode v6
}

