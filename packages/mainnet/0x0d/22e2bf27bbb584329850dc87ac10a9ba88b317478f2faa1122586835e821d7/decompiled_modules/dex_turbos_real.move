module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_turbos_real {
    struct RealTurbosSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        sqrt_price_after: u128,
        success: bool,
    }

    public fun get_turbos_pools() : (address, address, address) {
        (@0x82e3d6ebeb2e7d145c73a88845b210e31905d38b7539c30cc420a0e4e8f30fcd, @0x2c6fc12bf0d093b5391e7c0fed7e044d52bc14eb29f6352a3fb358e33e80729e, @0xe95b59189339a87ea5219ebd5fa168f5d568d015ac5c3f192eecf0d090ec832d)
    }

    public fun is_turbos_ready() : bool {
        false
    }

    public fun swap_multi_hop_real<T0, T1, T2>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = swap_real<T0, T1>(arg0, arg2, 0, 0, true, arg4, arg5);
        swap_real<T1, T2>(arg1, v0, arg3, 0, true, arg4, arg5)
    }

    public fun swap_real<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 702);
        let v1 = RealTurbosSwapExecuted{
            pool             : arg0,
            amount_in        : v0,
            amount_out       : arg2,
            sqrt_price_after : arg3,
            success          : false,
        };
        0x2::event::emit<RealTurbosSwapExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg6)
    }

    // decompiled from Move bytecode v6
}

