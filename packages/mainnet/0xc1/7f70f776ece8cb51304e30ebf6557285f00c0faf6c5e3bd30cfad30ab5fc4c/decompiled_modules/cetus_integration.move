module 0xc17f70f776ece8cb51304e30ebf6557285f00c0faf6c5e3bd30cfad30ab5fc4c::cetus_integration {
    public fun get_new_tick_range<T0, T1>(arg0: &mut 0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::AutoRebalanceStrategy<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::AutoRebalanceReceipt<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9) = 0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::prepare_rebalance<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), arg2);
        let v10 = v8;
        let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v10);
        let v13 = if (v3) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v11) * ((10000 - v1) as u128) / 10000
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v11) * ((10000 + v1) as u128) / 10000
        };
        let v14 = if (v4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v12) * ((10000 + v2) as u128) / 10000
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v12) * ((10000 - v2) as u128) / 10000
        };
        if (v0 < v13 || v0 > v14) {
            abort 0
        };
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v0 * ((10000 - v5) as u128) / 10000);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v0 * ((10000 + v5) as u128) / 10000);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(v15, v16) == 0) {
            abort 1
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(v15, v7) == 2 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(v16, v6) == 0) {
            abort 2
        };
        (v15, v16, v10, v9)
    }

    public fun new_strategy(arg0: vector<u8>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::AutoRebalanceStrategy<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::new_auto_rebalance_strategy<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg2, arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

