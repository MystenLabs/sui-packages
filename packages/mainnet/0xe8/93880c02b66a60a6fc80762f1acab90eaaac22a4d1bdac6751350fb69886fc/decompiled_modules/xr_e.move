module 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::xr_e {
    public fun es0<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::bl(arg0, 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg2), true);
        if (!0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, true, 0, 0x2::coin::from_balance<T0>(arg3, arg5), 0x2::coin::zero<T1>(arg5), arg4, arg5);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun es1<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::bl(arg0, 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg2), false);
        if (!0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, false, 0, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(arg3, arg5), arg4, arg5);
        0x2::coin::destroy_zero<T1>(v1);
        0x2::coin::into_balance<T0>(v0)
    }

    // decompiled from Move bytecode v7
}

