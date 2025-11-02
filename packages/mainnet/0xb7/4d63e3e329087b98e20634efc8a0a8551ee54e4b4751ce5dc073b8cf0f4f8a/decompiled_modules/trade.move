module 0xb74d63e3e329087b98e20634efc8a0a8551ee54e4b4751ce5dc073b8cf0f4f8a::trade {
    struct PairInfo has copy, drop {
        reserve_x: u64,
        reserve_y: u64,
    }

    public fun calculate_swaps<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>) {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0));
        let v2 = PairInfo{
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<PairInfo>(v2);
    }

    // decompiled from Move bytecode v6
}

