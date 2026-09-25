module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::cetus_graduation {
    public(friend) fun collect_lp_fees<T0, T1, T2, T3>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>, arg2: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::LockedLiquidity<T2, T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::source_pool_id<T2, T3>(arg2) == 0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>>(arg0), 4);
        let (v0, v1) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::lp_fee_routing<T0, T1>(arg0, arg1, 0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::LockedLiquidity<T2, T3>>(arg2));
        let (v2, v3) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::collect_fees<T2, T3>(arg2, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = route<T2>(v5, v0, v1);
        let (v8, v9) = route<T3>(v4, v0, v1);
        let v10 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::token_is_a<T2, T3>(arg2);
        let (v11, v12) = orient(v10, 0x2::balance::value<T2>(&v5), 0x2::balance::value<T3>(&v4));
        let (v13, v14) = orient(v10, v6, v8);
        let (v15, v16) = orient(v10, v7, v9);
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events::lp_fees_collected(0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>>(arg0), 0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::LockedLiquidity<T2, T3>>(arg2), 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::cetus_pool_id<T2, T3>(arg2), 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::position_id<T2, T3>(arg2), v11, v12, v13, v14, v15, v16, v0, v1, 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5));
    }

    fun deploy<T0, T1>(arg0: 0x2::object::ID, arg1: bool, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: u128, arg6: u32, arg7: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, u64, u64, u64, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(arg6);
        let v2 = 0x2::balance::value<T0>(&arg2);
        let v3 = 0x2::balance::value<T1>(&arg3);
        let v4 = if (arg4) {
            v2
        } else {
            v3
        };
        let (_, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg5), arg5, v4, arg4);
        assert!(v6 <= v2 && v7 <= v3, 1);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, T1>(arg8, arg9, &arg7, arg6, arg5, 0x1::string::utf8(b""), v0, v1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v6), arg11), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3, v7), arg11), arg4, arg10, arg11);
        0x2::balance::join<T0>(&mut arg2, 0x2::coin::into_balance<T0>(v9));
        0x2::balance::join<T1>(&mut arg3, 0x2::coin::into_balance<T1>(v10));
        let v11 = 0x2::balance::value<T0>(&arg2);
        let v12 = 0x2::balance::value<T1>(&arg3);
        assert!(arg4 && v11 <= 1 || v12 <= 1, 1);
        let (v13, v14, v15) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::freeze_forever<T0, T1>(arg0, arg1, v8, arg7, arg2, arg3, arg11);
        (v13, v14, v15, v2 - v11, v3 - v12, v11, v12)
    }

    public(friend) fun graduate<T0, T1>(arg0: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::take_graduation_reserves<T0, T1>(arg0);
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::take_creation_cap<T0, T1>(arg0);
        let v7 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::token_is_a<T0, T1>();
        let v8 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::sqrt_price_x64(0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), v2, v7);
        let (v9, v10, v11, v12, v13, v14, v15) = if (v7) {
            deploy<T0, T1>(0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>>(arg0), true, v5, v4, false, v8, v3, v6, arg1, arg2, arg3, arg4)
        } else {
            let (v16, v17, v18, v19, v20, v21, v22) = deploy<T1, T0>(0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>>(arg0), false, v4, v5, true, v8, v3, v6, arg1, arg2, arg3, arg4);
            (v16, v17, v18, v20, v19, v22, v21)
        };
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::finish_graduation<T0, T1>(arg0, v9, v11, arg3, arg4);
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events::graduated(0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>>(arg0), v9, v10, v11, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&v6), v7, v8, v3, v12, v13, v14, v15, 0x2::clock::timestamp_ms(arg3));
    }

    fun orient(arg0: bool, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg0) {
            (arg1, arg2)
        } else {
            (arg2, arg1)
        }
    }

    public(friend) fun reserve_pair<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: u32, arg3: &mut 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg0, arg1, arg3, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, T1>(arg0, arg1, arg2, &v0, arg4);
        v0
    }

    fun route<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: address) : (u64, u64) {
        let (v0, v1) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::split_lp_fee(0x2::balance::value<T0>(&arg0));
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0, v0), arg1);
        0x2::balance::send_funds<T0>(arg0, arg2);
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

