module 0xad5fd7558e59fda044dcf98985580d66406d6e171322ccaaa1151a8574d8ce1::cetus_integration {
    public fun get_new_tick_range<T0, T1>(arg0: &mut 0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::AutoRebalanceStrategy<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::AutoRebalanceReceipt<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::prepare_rebalance<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, v0, arg2);
        let v11 = v9;
        let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v11);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(v0, v8) == 0 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(v0, v7) == 2) {
            abort 2
        };
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v12);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v13);
        let v16 = if (v4) {
            v14 + v14 * (v2 as u128) / 10000
        } else {
            v14 - v14 * (v2 as u128) / 10000
        };
        let v17 = if (v5) {
            v15 - v15 * (v3 as u128) / 10000
        } else {
            v15 + v15 * (v3 as u128) / 10000
        };
        if (v1 < v16 || v1 > v17) {
            abort 0
        };
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v1 - v1 * (v6 as u128) / 10000);
        let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v1 + v1 * (v6 as u128) / 10000);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(v18, v19) == 2) {
            abort 1
        };
        (v18, v19, v11, v10)
    }

    public fun new_strategy(arg0: vector<u8>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::AutoRebalanceStrategy<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::auto_rebalance::new_auto_rebalance_strategy<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg2, arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

