module 0x13fd320921d9f95c087b1d7bf405dcf4bf86a8dac20fc80d0520d1152dbdc31c::trade {
    public fun calculate_swaps<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u64, arg2: u128) : (u32, u64, u64) {
        let v0 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0);
        let (v1, v2) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, v0);
        let v3 = if (v1 == 0) {
            true
        } else if (v2 == 0) {
            true
        } else {
            arg2 == 0
        };
        let v4 = if (v3) {
            0
        } else {
            (((v1 as u256) * (arg1 as u256) * (arg2 as u256) / ((v2 as u256) * (arg2 as u256) + (v1 as u256) * 1000000000)) as u64)
        };
        let v5 = if (arg2 > 0) {
            (((v4 as u128) * 1000000000 / arg2) as u64)
        } else {
            0
        };
        (v0, v4, v5)
    }

    // decompiled from Move bytecode v6
}

