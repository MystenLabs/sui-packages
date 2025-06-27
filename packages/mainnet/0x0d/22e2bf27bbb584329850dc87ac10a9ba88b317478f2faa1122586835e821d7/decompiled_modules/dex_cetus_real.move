module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_cetus_real {
    struct RealCetusSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        sqrt_price_after: u128,
        success: bool,
    }

    public fun flash_swap_real<T0, T1>(arg0: address, arg1: u64, arg2: bool, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        (0x2::coin::zero<T1>(arg5), arg1 * 10025 / 10000)
    }

    public fun get_cetus_pools() : (address, address) {
        (@0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, @0xcbe3e6bbce4e0a03cc5f6e4272abee59793cb892600fa955e3a7754f16ef60f)
    }

    public fun is_cetus_ready() : bool {
        false
    }

    public fun swap_real<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 602);
        let v1 = RealCetusSwapExecuted{
            pool             : arg0,
            amount_in        : v0,
            amount_out       : arg2,
            sqrt_price_after : arg3,
            success          : false,
        };
        0x2::event::emit<RealCetusSwapExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg5)
    }

    // decompiled from Move bytecode v6
}

