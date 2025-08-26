module 0x51ac5a80cec44f4d51baee915488eccd70119f95d6eb5fe98ffc737bfa0bbc63::cetus_tick_lens {
    public fun fetch_ticks<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : vector<0x51ac5a80cec44f4d51baee915488eccd70119f95d6eb5fe98ffc737bfa0bbc63::tick_info::TickInfo> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x1::vector::empty<0x51ac5a80cec44f4d51baee915488eccd70119f95d6eb5fe98ffc737bfa0bbc63::tick_info::TickInfo>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v0)) {
            let v3 = 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v0, v2);
            0x1::vector::push_back<0x51ac5a80cec44f4d51baee915488eccd70119f95d6eb5fe98ffc737bfa0bbc63::tick_info::TickInfo>(&mut v1, 0x51ac5a80cec44f4d51baee915488eccd70119f95d6eb5fe98ffc737bfa0bbc63::tick_info::new(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(v3)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_gross(v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

