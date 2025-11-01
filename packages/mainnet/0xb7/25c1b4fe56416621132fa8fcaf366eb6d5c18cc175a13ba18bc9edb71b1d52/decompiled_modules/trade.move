module 0xb725c1b4fe56416621132fa8fcaf366eb6d5c18cc175a13ba18bc9edb71b1d52::trade {
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
        let v6 = if (arg1 > v5) {
            arg1 - v5
        } else {
            0
        };
        (v0, v6, v5)
    }

    public fun calculate_swaps_withrate<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u64, arg2: u128) : (u32, u64, u64, u64, u64) {
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
        let v6 = if (arg1 > v5) {
            arg1 - v5
        } else {
            0
        };
        let v7 = (v4 as u128) + (v5 as u128);
        let (v8, v9) = if (v7 == 0) {
            (0, 0)
        } else {
            ((((v4 as u128) * 1000000000 / v7) as u64), (((v5 as u128) * 1000000000 / v7) as u64))
        };
        (v0, v6, v5, v8, v9)
    }

    // decompiled from Move bytecode v6
}

