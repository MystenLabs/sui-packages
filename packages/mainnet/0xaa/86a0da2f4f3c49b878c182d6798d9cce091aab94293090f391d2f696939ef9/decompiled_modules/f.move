module 0xaa86a0da2f4f3c49b878c182d6798d9cce091aab94293090f391d2f696939ef9::f {
    public fun fsxy<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, true, 0, arg2, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        0xaa86a0da2f4f3c49b878c182d6798d9cce091aab94293090f391d2f696939ef9::u::tod<T0>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun fsyx<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, false, 0, 0x2::coin::zero<T0>(arg4), arg2, arg3, arg4);
        0xaa86a0da2f4f3c49b878c182d6798d9cce091aab94293090f391d2f696939ef9::u::tod<T1>(v1, 0x2::tx_context::sender(arg4));
        v0
    }

    // decompiled from Move bytecode v6
}

