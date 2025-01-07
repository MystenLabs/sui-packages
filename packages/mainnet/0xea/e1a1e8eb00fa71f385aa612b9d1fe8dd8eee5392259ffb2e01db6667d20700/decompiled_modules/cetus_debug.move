module 0xeae1a1e8eb00fa71f385aa612b9d1fe8dd8eee5392259ffb2e01db6667d20700::cetus_debug {
    struct SwapTickEvent has copy, drop {
        pool_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        swap_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        score: u64,
        score2: u64,
    }

    public fun swap_tick_for_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(v0, v1, arg1);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v2)) {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v2);
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(v0, v3, arg1);
            let v6 = v5;
            let v7 = if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v6)) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v6)
            } else {
                0
            };
            let v8 = SwapTickEvent{
                pool_index : v1,
                swap_index : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(v4),
                score      : v3,
                score2     : v7,
            };
            0x2::event::emit<SwapTickEvent>(v8);
        } else {
            let v9 = SwapTickEvent{
                pool_index : v1,
                swap_index : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero(),
                score      : 0,
                score2     : 0,
            };
            0x2::event::emit<SwapTickEvent>(v9);
        };
    }

    // decompiled from Move bytecode v6
}

