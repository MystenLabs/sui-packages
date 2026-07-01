module 0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::ferra {
    struct FerraDlmmQuote has copy, drop, store {
        a2b_out: u64,
        b2a_out: u64,
    }

    public fun a2b_dlmm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, true, 0, arg0, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::self::transfer_or_destroy_coin<T0>(v0, arg4);
        v1
    }

    public fun b2a_dlmm<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, false, 0, 0x2::coin::zero<T0>(arg4), arg0, arg3, arg4);
        0x66f23f19bde9c628c909b8e3dff18cc23238f5bc1143c8fa02967d93e60adedc::self::transfer_or_destroy_coin<T1>(v1, arg4);
        v0
    }

    public fun probe_dlmm<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : FerraDlmmQuote {
        let (v0, _, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg1, true, arg3);
        let (v3, _, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg2, false, arg3);
        FerraDlmmQuote{
            a2b_out : v0,
            b2a_out : v3,
        }
    }

    // decompiled from Move bytecode v7
}

