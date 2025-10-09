module 0xaf78fb4aef3d58d9d8921405574dea251303ba339f641b7bfd094f92a7bd5024::lb_position {
    public fun get_position_balance<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition, arg2: u32, arg3: u32) : (u64, u64) {
        let (v0, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::get_tokens_in_position(0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_position_manager<T0, T1>(arg0), arg1, arg2, arg3);
        let (v2, v3) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_position_reserves_for_bins<T0, T1>(arg0, arg1, v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&v5)) {
            v7 = v7 + *0x1::vector::borrow<u64>(&v5, v8);
            v6 = v6 + *0x1::vector::borrow<u64>(&v4, v8);
            v8 = v8 + 1;
        };
        (v7, v6)
    }

    // decompiled from Move bytecode v6
}

