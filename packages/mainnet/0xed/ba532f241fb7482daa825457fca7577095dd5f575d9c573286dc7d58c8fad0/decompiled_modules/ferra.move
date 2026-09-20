module 0xedba532f241fb7482daa825457fca7577095dd5f575d9c573286dc7d58c8fad0::ferra {
    public fun a2b<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, true, 0, 0x2::coin::from_balance<T0>(arg2, arg4), 0x2::coin::zero<T1>(arg4), arg3, arg4);
        let v2 = v0;
        assert!(0x2::coin::value<T0>(&v2) == 0, 140);
        0x2::coin::destroy_zero<T0>(v2);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun b2a<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, false, 0, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(arg2, arg4), arg3, arg4);
        let v2 = v1;
        assert!(0x2::coin::value<T1>(&v2) == 0, 140);
        0x2::coin::destroy_zero<T1>(v2);
        0x2::coin::into_balance<T0>(v0)
    }

    // decompiled from Move bytecode v7
}

