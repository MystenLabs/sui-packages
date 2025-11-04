module 0x45d795d7078af5e9342bd387de531dacbbffaa3b89a8810cf64205586a31e34d::trade {
    struct PairInfo has copy, drop {
        active_id: u32,
        reserve_x: u64,
        reserve_y: u64,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
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

    public fun calculate_swaps_v2<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        let (_, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0));
        if (arg1 < v1) {
            let (_, v3, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg1, false, arg2);
            let v5 = SwapResult{
                amount_in  : arg1,
                amount_out : v3,
            };
            0x2::event::emit<SwapResult>(v5);
        } else if (v1 > 100000000) {
            let v6 = v1 - v1 / 100;
            let (_, v8, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, v6, false, arg2);
            let v10 = SwapResult{
                amount_in  : v6,
                amount_out : v8,
            };
            0x2::event::emit<SwapResult>(v10);
        };
    }

    public fun calculate_swaps_v3<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        let (_, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0));
        if (arg1 < v1) {
            let (_, v3, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg1, false, arg2);
            let v5 = SwapResult{
                amount_in  : arg1,
                amount_out : v3,
            };
            0x2::event::emit<SwapResult>(v5);
            return
        };
        if (v1 > 100000000) {
            let v6 = v1 - v1 / 100;
            let (_, v8, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, v6, false, arg2);
            let v10 = SwapResult{
                amount_in  : v6,
                amount_out : v8,
            };
            0x2::event::emit<SwapResult>(v10);
            return
        };
        let (_, v12, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg1, false, arg2);
        let v14 = SwapResult{
            amount_in  : arg1,
            amount_out : v12,
        };
        0x2::event::emit<SwapResult>(v14);
    }

    // decompiled from Move bytecode v6
}

