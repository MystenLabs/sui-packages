module 0x94e79c9e37982e72c91707edb84af53e9e28130d6da962090014f7c5ed427bd5::ferra_dlmm {
    public fun swap<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, true, 0, 0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::zero<T1>(arg5), arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::value<T0>(&v5);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v5));
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v4));
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::emit_swap_event<T0, T1>(arg0, b"FERRADLMM", 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg2), v1 - v6, 0x2::coin::value<T1>(&v4), v6);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, false, 0, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(v0, arg5), arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::value<T1>(&v4);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v4));
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v5));
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::emit_swap_event<T1, T0>(arg0, b"FERRADLMM", 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg2), v1 - v6, 0x2::coin::value<T0>(&v5), v6);
    }

    // decompiled from Move bytecode v6
}

