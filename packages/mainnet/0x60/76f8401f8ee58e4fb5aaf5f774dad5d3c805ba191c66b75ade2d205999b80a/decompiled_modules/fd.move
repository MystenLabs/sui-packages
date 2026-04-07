module 0x6076f8401f8ee58e4fb5aaf5f774dad5d3c805ba191c66b75ade2d205999b80a::fd {
    public fun a<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, true, 0, arg2, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        0xe7e491e54c1227d5106eef4fa97c6f5697005db4517bca88abcc580963cbaed2::vv::tdc<T0>(v0, arg4);
        v1
    }

    public fun b<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, false, 0, 0x2::coin::zero<T0>(arg4), arg2, arg3, arg4);
        0xe7e491e54c1227d5106eef4fa97c6f5697005db4517bca88abcc580963cbaed2::vv::tdc<T1>(v1, arg4);
        v0
    }

    // decompiled from Move bytecode v7
}

