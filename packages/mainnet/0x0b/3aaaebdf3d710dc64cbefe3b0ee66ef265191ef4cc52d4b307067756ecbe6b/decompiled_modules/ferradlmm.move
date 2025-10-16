module 0xb3aaaebdf3d710dc64cbefe3b0ee66ef265191ef4cc52d4b307067756ecbe6b::ferradlmm {
    public fun swap_a2b<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, true, 0, arg2, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        0xb3aaaebdf3d710dc64cbefe3b0ee66ef265191ef4cc52d4b307067756ecbe6b::utils::transfer_or_destroy_coin<T0>(v0, arg4);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, false, 0, 0x2::coin::zero<T0>(arg4), arg2, arg3, arg4);
        0xb3aaaebdf3d710dc64cbefe3b0ee66ef265191ef4cc52d4b307067756ecbe6b::utils::transfer_or_destroy_coin<T1>(v1, arg4);
        v0
    }

    // decompiled from Move bytecode v6
}

