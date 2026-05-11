module 0xede190ef4e4db2e9737a6c7d4df6e1b68e0c61cd64908ae3c938b3fbfb4ad44::rebalancer {
    struct OpenSpec has copy, drop, store {
        tick_lower: u32,
        tick_upper: u32,
    }

    struct RebalanceExecuted has copy, drop {
        sender: address,
        n_closed: u64,
        n_opened: u64,
        closed_position_ids: vector<0x2::object::ID>,
        new_position_ids: vector<0x2::object::ID>,
        new_tick_min: u32,
        new_tick_max: u32,
        current_tick: u32,
        current_sqrt_price: u128,
        total_liq_closed: u128,
        total_liq_opened: u128,
        swap_a_to_b: bool,
        swap_amount_in: u64,
        swap_amount_out: u64,
        timestamp_ms: u64,
    }

    struct ToppedUp has copy, drop {
        sender: address,
        position_id: 0x2::object::ID,
        liq_before: u128,
        liq_after: u128,
        amount_a_added: u64,
        amount_b_added: u64,
        current_tick: u32,
        current_sqrt_price: u128,
        swap_a_to_b: bool,
        swap_amount_in: u64,
        timestamp_ms: u64,
    }

    struct WithdrawnPartial has copy, drop {
        sender: address,
        position_id: 0x2::object::ID,
        fraction_bps: u16,
        liq_before: u128,
        liq_after: u128,
        amount_a_out: u64,
        amount_b_out: u64,
        current_tick: u32,
        current_sqrt_price: u128,
        timestamp_ms: u64,
    }

    struct FeesOnlyCollected has copy, drop {
        sender: address,
        position_id: 0x2::object::ID,
        fee_a: u64,
        fee_b: u64,
        reward: u64,
        current_tick: u32,
        current_sqrt_price: u128,
        timestamp_ms: u64,
    }

    struct GridInitialized has copy, drop {
        sender: address,
        n_opened: u64,
        new_position_ids: vector<0x2::object::ID>,
        new_tick_min: u32,
        new_tick_max: u32,
        current_tick: u32,
        current_sqrt_price: u128,
        total_liq_opened: u128,
        swap_a_to_b: bool,
        swap_amount_in: u64,
        swap_amount_out: u64,
        timestamp_ms: u64,
    }

    struct GridClosed has copy, drop {
        sender: address,
        n_closed: u64,
        closed_position_ids: vector<0x2::object::ID>,
        total_liq_closed: u128,
        amount_a_out: u64,
        amount_b_out: u64,
        amount_reward_out: u64,
        current_tick: u32,
        current_sqrt_price: u128,
        timestamp_ms: u64,
    }

    public fun close_all_atomic<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3);
        assert!(v0 > 0, 2);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        let v3 = 0x2::coin::zero<T0>(arg5);
        let v4 = 0x2::coin::zero<T1>(arg5);
        let v5 = 0x2::coin::zero<T2>(arg5);
        let v6 = 0;
        while (v6 < v0) {
            let v7 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v7));
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v7);
            v2 = v2 + v8;
            0x2::coin::join<T2>(&mut v5, 0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg0, arg1, &v7, arg2, true, arg4), arg5));
            let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut v7, v8, arg4);
            let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, &v7, true);
            0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(v9, arg5));
            0x2::coin::join<T1>(&mut v4, 0x2::coin::from_balance<T1>(v10, arg5));
            0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(v11, arg5));
            0x2::coin::join<T1>(&mut v4, 0x2::coin::from_balance<T1>(v12, arg5));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg0, arg1, v7);
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3);
        let v13 = GridClosed{
            sender              : 0x2::tx_context::sender(arg5),
            n_closed            : v0,
            closed_position_ids : v1,
            total_liq_closed    : v2,
            amount_a_out        : 0x2::coin::value<T0>(&v3),
            amount_b_out        : 0x2::coin::value<T1>(&v4),
            amount_reward_out   : 0x2::coin::value<T2>(&v5),
            current_tick        : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1)),
            current_sqrt_price  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<GridClosed>(v13);
        (v3, v4, v5)
    }

    public fun collect_fees_only<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, arg3, true);
        let v2 = 0x2::coin::from_balance<T0>(v0, arg5);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg5);
        let v4 = 0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg3, arg2, true, arg4), arg5);
        let v5 = FeesOnlyCollected{
            sender             : 0x2::tx_context::sender(arg5),
            position_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3),
            fee_a              : 0x2::coin::value<T0>(&v2),
            fee_b              : 0x2::coin::value<T1>(&v3),
            reward             : 0x2::coin::value<T2>(&v4),
            current_tick       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1)),
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1),
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<FeesOnlyCollected>(v5);
        (v2, v3, v4)
    }

    public fun init_grid_atomic<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<OpenSpec>, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        let v0 = 0x1::vector::length<OpenSpec>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = arg3 * 99 / 100;
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v5 = 0;
        let v6 = 0;
        let v7 = 4294967295;
        let v8 = 0;
        let v9 = 0;
        while (v9 < v0) {
            let v10 = 0x1::vector::borrow<OpenSpec>(&arg2, v9);
            let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v10.tick_lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v10.tick_upper), v3, v4, v2, true);
            v5 = v5 + v11;
            v6 = v6 + v12;
            if (v10.tick_lower < v7) {
                v7 = v10.tick_lower;
            };
            if (v10.tick_upper > v8) {
                v8 = v10.tick_upper;
            };
            v9 = v9 + 1;
        };
        let v13 = 0x2::coin::value<T0>(&arg5);
        let v14 = 0x2::coin::value<T1>(&arg6);
        let v15 = false;
        let v16 = 0;
        let v17 = 0;
        if (v5 > v13) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, v5 - v13, arg4, arg7);
            let v21 = v20;
            let v22 = v18;
            let v23 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v21);
            v16 = v23;
            v17 = 0x2::balance::value<T0>(&v22);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, v23, arg8)), v21);
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v22, arg8));
            0x2::balance::destroy_zero<T1>(v19);
        } else if (v6 > v14) {
            let (v24, v25, v26) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v6 - v14, arg4, arg7);
            let v27 = v26;
            let v28 = v25;
            v15 = true;
            let v29 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v27);
            v16 = v29;
            v17 = 0x2::balance::value<T1>(&v28);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v29, arg8)), 0x2::balance::zero<T1>(), v27);
            0x2::coin::join<T1>(&mut arg6, 0x2::coin::from_balance<T1>(v28, arg8));
            0x2::balance::destroy_zero<T0>(v24);
        };
        let v30 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        let v31 = 0x1::vector::empty<0x2::object::ID>();
        let v32 = 0;
        while (v32 < v0) {
            let v33 = 0x1::vector::pop_back<OpenSpec>(&mut arg2);
            let v34 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, v33.tick_lower, v33.tick_upper, arg8);
            0x1::vector::push_back<0x2::object::ID>(&mut v31, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v34));
            let v35 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v34, v2, arg7);
            let (v36, v37) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v35);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v36, arg8)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, v37, arg8)), v35);
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v30, v34);
            v32 = v32 + 1;
        };
        0x1::vector::destroy_empty<OpenSpec>(arg2);
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        if (0x2::coin::value<T1>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, v1);
        } else {
            0x2::coin::destroy_zero<T1>(arg6);
        };
        let v38 = GridInitialized{
            sender             : v1,
            n_opened           : v0,
            new_position_ids   : v31,
            new_tick_min       : v7,
            new_tick_max       : v8,
            current_tick       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3),
            current_sqrt_price : v4,
            total_liq_opened   : v2 * (v0 as u128),
            swap_a_to_b        : v15,
            swap_amount_in     : v16,
            swap_amount_out    : v17,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<GridInitialized>(v38);
        v30
    }

    public fun liq_margin_den() : u128 {
        100
    }

    public fun liq_margin_num() : u128 {
        99
    }

    public fun new_open_spec(arg0: u32, arg1: u32) : OpenSpec {
        OpenSpec{
            tick_lower : arg0,
            tick_upper : arg1,
        }
    }

    public fun rebalance_atomic<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg4: vector<OpenSpec>, arg5: u128, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        let v0 = 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3);
        assert!(v0 == 0x1::vector::length<OpenSpec>(&arg4), 1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v5));
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v5);
            v3 = v3 + v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg0, arg1, &v5, arg2, true, arg8), arg9), v1);
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut v5, v6, arg8);
            let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, &v5, true);
            0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v7, arg9));
            0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v8, arg9));
            0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v9, arg9));
            0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v10, arg9));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg0, arg1, v5);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3);
        let v11 = v3 * 99 / (v0 as u128) / 100;
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v14 = 0;
        let v15 = 0;
        let v16 = 4294967295;
        let v17 = 0;
        let v18 = 0;
        while (v18 < v0) {
            let v19 = 0x1::vector::borrow<OpenSpec>(&arg4, v18);
            let (v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v19.tick_lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v19.tick_upper), v12, v13, v11, true);
            v14 = v14 + v20;
            v15 = v15 + v21;
            if (v19.tick_lower < v16) {
                v16 = v19.tick_lower;
            };
            if (v19.tick_upper > v17) {
                v17 = v19.tick_upper;
            };
            v18 = v18 + 1;
        };
        let v22 = 0x2::coin::value<T0>(&arg6);
        let v23 = 0x2::coin::value<T1>(&arg7);
        let v24 = false;
        let v25 = 0;
        let v26 = 0;
        if (v14 > v22) {
            let (v27, v28, v29) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, v14 - v22, arg5, arg8);
            let v30 = v29;
            let v31 = v27;
            let v32 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v30);
            v25 = v32;
            v26 = 0x2::balance::value<T0>(&v31);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg7, v32, arg9)), v30);
            0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v31, arg9));
            0x2::balance::destroy_zero<T1>(v28);
        } else if (v15 > v23) {
            let (v33, v34, v35) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v15 - v23, arg5, arg8);
            let v36 = v35;
            let v37 = v34;
            v24 = true;
            let v38 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v36);
            v25 = v38;
            v26 = 0x2::balance::value<T1>(&v37);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg6, v38, arg9)), 0x2::balance::zero<T1>(), v36);
            0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v37, arg9));
            0x2::balance::destroy_zero<T0>(v33);
        };
        let v39 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        let v40 = 0x1::vector::empty<0x2::object::ID>();
        let v41 = 0;
        while (v41 < v0) {
            let v42 = 0x1::vector::pop_back<OpenSpec>(&mut arg4);
            let v43 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, v42.tick_lower, v42.tick_upper, arg9);
            0x1::vector::push_back<0x2::object::ID>(&mut v40, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v43));
            let v44 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v43, v11, arg8);
            let (v45, v46) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v44);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg6, v45, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg7, v46, arg9)), v44);
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v39, v43);
            v41 = v41 + 1;
        };
        0x1::vector::destroy_empty<OpenSpec>(arg4);
        if (0x2::coin::value<T0>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, v1);
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
        if (0x2::coin::value<T1>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, v1);
        } else {
            0x2::coin::destroy_zero<T1>(arg7);
        };
        let v47 = RebalanceExecuted{
            sender              : v1,
            n_closed            : v0,
            n_opened            : v0,
            closed_position_ids : v2,
            new_position_ids    : v40,
            new_tick_min        : v16,
            new_tick_max        : v17,
            current_tick        : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v12),
            current_sqrt_price  : v13,
            total_liq_closed    : v3,
            total_liq_opened    : v11 * (v0 as u128),
            swap_a_to_b         : v24,
            swap_amount_in      : v25,
            swap_amount_out     : v26,
            timestamp_ms        : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<RebalanceExecuted>(v47);
        v39
    }

    public fun spec_tick_lower(arg0: &OpenSpec) : u32 {
        arg0.tick_lower
    }

    public fun spec_tick_upper(arg0: &OpenSpec) : u32 {
        arg0.tick_upper
    }

    public fun topup_atomic<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = arg3 * 99 / 100;
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg2);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v2, v3, v4, v5, v1, true);
        let v8 = false;
        let v9 = 0;
        if (v6 > 0x2::coin::value<T0>(&arg5)) {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, v6 - 0x2::coin::value<T0>(&arg5), arg4, arg7);
            let v13 = v12;
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
            v9 = v14;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, v14, arg8)), v13);
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v10, arg8));
            0x2::balance::destroy_zero<T1>(v11);
        } else if (v7 > 0x2::coin::value<T1>(&arg6)) {
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v7 - 0x2::coin::value<T1>(&arg6), arg4, arg7);
            let v18 = v17;
            v8 = true;
            let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18);
            v9 = v19;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v19, arg8)), 0x2::balance::zero<T1>(), v18);
            0x2::coin::join<T1>(&mut arg6, 0x2::coin::from_balance<T1>(v16, arg8));
            0x2::balance::destroy_zero<T0>(v15);
        };
        let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, v1, arg7);
        let (v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v21, arg8)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, v22, arg8)), v20);
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        if (0x2::coin::value<T1>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, v0);
        } else {
            0x2::coin::destroy_zero<T1>(arg6);
        };
        let v23 = ToppedUp{
            sender             : v0,
            position_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg2),
            liq_before         : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg2),
            liq_after          : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg2),
            amount_a_added     : v21,
            amount_b_added     : v22,
            current_tick       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4),
            current_sqrt_price : v5,
            swap_a_to_b        : v8,
            swap_amount_in     : v9,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ToppedUp>(v23);
    }

    public fun withdraw_atomic<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: u16, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg3 > 0 && (arg3 as u64) <= 10000, 3);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg2);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, (((v0 as u256) * (arg3 as u256) / (10000 as u256)) as u128), arg4);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg5);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg5);
        let v5 = WithdrawnPartial{
            sender             : 0x2::tx_context::sender(arg5),
            position_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg2),
            fraction_bps       : arg3,
            liq_before         : v0,
            liq_after          : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg2),
            amount_a_out       : 0x2::coin::value<T0>(&v3),
            amount_b_out       : 0x2::coin::value<T1>(&v4),
            current_tick       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1)),
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1),
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<WithdrawnPartial>(v5);
        (v3, v4)
    }

    // decompiled from Move bytecode v7
}

