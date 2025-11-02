module 0x6886d157def9be02fb6f897337bed6e24fe1d9563e5de83d363d12d4e423e7a8::trade {
    struct PairInfo has copy, drop {
        active_id: u32,
        reserve_x: u64,
        reserve_y: u64,
    }

    public fun calculate_swaps<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>) {
        let v0 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0);
        let (v1, v2) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, v0);
        let v3 = PairInfo{
            active_id : v0,
            reserve_x : v1,
            reserve_y : v2,
        };
        0x2::event::emit<PairInfo>(v3);
    }

    // decompiled from Move bytecode v6
}

