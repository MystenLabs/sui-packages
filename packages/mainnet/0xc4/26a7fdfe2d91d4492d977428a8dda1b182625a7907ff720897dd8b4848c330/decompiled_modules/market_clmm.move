module 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::market_clmm {
    struct CLMMMarket has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        certified_pools: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        position_keys: 0x2::vec_set::VecSet<0x2::object::ID>,
        positions: 0x2::object_bag::ObjectBag,
    }

    struct CLMMPosition has store, key {
        id: 0x2::object::UID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        amounts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        last_txs: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    public(friend) fun close_position<T0, T1>(arg0: &mut CLMMMarket, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835340960483115011);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835340964778082307);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.position_keys, &arg2);
        let CLMMPosition {
            id       : v0,
            position : v1,
            amounts  : _,
            last_txs : _,
        } = 0x2::object_bag::remove<0x2::object::ID, CLMMPosition>(&mut arg0.positions, arg2);
        0x2::object::delete(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg3, arg1, v1);
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut CLMMMarket, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13836747635287392265);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg4, arg1, arg2, arg3, arg5);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1);
        let v3 = CLMMPosition{
            id       : 0x2::object::new(arg5),
            position : v1,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v2);
        0x2::object_bag::add<0x2::object::ID, CLMMPosition>(&mut arg0.positions, v2, v3);
        v2
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut CLMMMarket, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u128, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835340870288801795);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835340874583769091);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, CLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 1, arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg4, arg1, &mut v0.position, arg3, arg5)
    }

    public fun pool_id(arg0: &CLMMPosition) : 0x2::object::ID {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg0.position)
    }

    public(friend) fun add_certified_pool<T0, T1>(arg0: &mut CLMMMarket, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.coin_type_a && 0x1::type_name::with_defining_ids<T1>() == arg0.coin_type_b || 0x1::type_name::with_defining_ids<T1>() == arg0.coin_type_a && 0x1::type_name::with_defining_ids<T0>() == arg0.coin_type_b, 13835058544908435457);
        assert!(!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13837310357607809037);
        assert!(arg2 <= 10000, 13838717736786853909);
        0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.certified_pools, v0, arg2);
    }

    fun amount_after_protocol_fee(arg0: u64, arg1: u64) : u64 {
        arg0 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(arg0, arg1, 10000)
    }

    public fun assert_clmm_position_not_withdraw(arg0: &CLMMMarket, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(contain_position(arg0, arg1), 13835341149461676035);
        let v0 = 0x2::object_bag::borrow<0x2::object::ID, CLMMPosition>(&arg0.positions, arg1);
        assert!(last_tx(v0, 1) != *0x2::tx_context::digest(arg2), 13837874441432727567);
        assert!(last_tx(v0, 4) != *0x2::tx_context::digest(arg2), 13838155933589438481);
        assert!(last_tx(v0, 3) != *0x2::tx_context::digest(arg2), 13838437425746149395);
    }

    public fun borrow_position(arg0: &CLMMMarket, arg1: 0x2::object::ID) : &CLMMPosition {
        assert!(contain_position(arg0, arg1), 13835341785116835843);
        0x2::object_bag::borrow<0x2::object::ID, CLMMPosition>(&arg0.positions, arg1)
    }

    public(friend) fun calculate_position_amounts<T0, T1>(arg0: &mut CLMMMarket, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341261130825731);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, CLMMPosition>(&mut arg0.positions, arg2);
        assert!(pool_id(v0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 13835622744697602053);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg1, arg2);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_tick_range(v1);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v2, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(v1), false);
        let v6 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v7 = 0x1::type_name::with_defining_ids<T0>();
        let v8 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, v7, v4);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, v8, v5);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_fee<T0, T1>(arg3, arg1, arg2);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v6, &v7) = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v6, &v7) + amount_after_protocol_fee(v9, arg4);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v6, &v8) = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v6, &v8) + amount_after_protocol_fee(v10, arg4);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_rewards<T0, T1>(arg3, arg1, arg2, arg5);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarders(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg1));
        let v13 = 0;
        while (v13 < 0x1::vector::length<u64>(&v11)) {
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::reward_coin(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v12, v13));
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v6, &v14)) {
                let v15 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v6, &v14);
                *v15 = *v15 + amount_after_protocol_fee(*0x1::vector::borrow<u64>(&v11, v13), arg4);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, v14, amount_after_protocol_fee(*0x1::vector::borrow<u64>(&v11, v13), arg4));
            };
            v13 = v13 + 1;
        };
        v0.amounts = v6;
        let v16 = 0;
        if (0x2::vec_map::contains<u8, vector<u8>>(&v0.last_txs, &v16)) {
            let v17 = 0;
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut v0.last_txs, &v17) = *0x2::tx_context::digest(arg6);
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut v0.last_txs, 0, *0x2::tx_context::digest(arg6));
        };
    }

    public fun certified_pools(arg0: &CLMMMarket) : 0x2::vec_map::VecMap<0x2::object::ID, u64> {
        arg0.certified_pools
    }

    public fun check_pool_price_deviation<T0, T1>(arg0: &CLMMMarket, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::PythOracle, arg3: &0x2::clock::Clock) {
        let v0 = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::get_price<T0>(arg2, arg3);
        let v1 = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::get_price<T1>(arg2, arg3);
        let (v2, _) = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::calculate_prices_v2(&v0, &v1);
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((10000 as u128), 0x1::u128::diff(v2, (get_current_pool_price<T0, T1>(arg1) as u128)), v2) <= (*0x2::vec_map::get<0x2::object::ID, u64>(&arg0.certified_pools, &v4) as u128), 13837030476063834123);
    }

    public fun coin_types(arg0: &CLMMMarket) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public(friend) fun collect_position_fee<T0, T1>(arg0: &mut CLMMMarket, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835340775799521283);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835340780094488579);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, CLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 3, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg1, &v0.position, true)
    }

    public(friend) fun collect_position_reward<T0, T1, T2>(arg0: &mut CLMMMarket, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835340681310240771);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835340685605208067);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, CLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 4, arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg4, arg1, &v0.position, arg3, true, arg5)
    }

    public fun contain_position(arg0: &CLMMMarket, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg1)
    }

    public fun get_current_pool_price<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        ((0x1::u256::pow((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) as u256) * 0x1::u256::pow(10, 20) / (18446744073709551616 as u256), 2) / 0x1::u256::pow(10, 20)) as u128)
    }

    public(friend) fun increase_liquidity<T0, T1>(arg0: &mut CLMMMarket, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::clock::Clock) : (u64, u64, u128) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835340384957497347);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835340389252464643);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, CLMMPosition>(&mut arg0.positions, arg2);
        let v1 = 0x2::balance::value<T1>(arg4);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v0.position);
        let v6 = if (v3 >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v5)) {
            let (v7, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v4, v5, v2, v3, v1, false);
            v7
        } else {
            let (v10, _, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v4, v5, v2, v3, 0x2::balance::value<T0>(arg3), true);
            if (v12 <= v1) {
                v10
            } else {
                let (v13, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v4, v5, v2, v3, v1, false);
                v13
            }
        };
        if (v6 == 0) {
            return (0, 0, 0)
        };
        let v16 = &mut v0.position;
        increase_liquidity_to_pool<T0, T1>(arg1, v16, arg5, arg3, arg4, v6, arg6)
    }

    fun increase_liquidity_to_pool<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: u128, arg6: &0x2::clock::Clock) : (u64, u64, u128) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg2, arg0, arg1, arg5, arg6);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v0);
        assert!(v1 <= 0x2::balance::value<T0>(arg3), 13839564137402335259);
        assert!(v2 <= 0x2::balance::value<T1>(arg4), 13839564141697302555);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg0, 0x2::balance::split<T0>(arg3, v1), 0x2::balance::split<T1>(arg4, v2), v0);
        (v1, v2, arg5)
    }

    public(friend) fun last_amounts(arg0: &CLMMMarket, arg1: &0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0;
        while (v1 < 0x2::vec_set::length<0x2::object::ID>(&arg0.position_keys)) {
            let v2 = 0x2::object_bag::borrow<0x2::object::ID, CLMMPosition>(&arg0.positions, *0x1::vector::borrow<0x2::object::ID>(0x2::vec_set::keys<0x2::object::ID>(&arg0.position_keys), v1));
            assert!(last_tx(v2, 0) == *0x2::tx_context::digest(arg1), 13835904000631111687);
            let v3 = 0;
            while (v3 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(&v2.amounts)) {
                let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v2.amounts, v3);
                if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0, v4)) {
                    let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0, v4);
                    *v6 = *v6 + *v5;
                } else {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, *v4, *v5);
                };
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun last_tx(arg0: &CLMMPosition, arg1: u8) : vector<u8> {
        if (!0x2::vec_map::contains<u8, vector<u8>>(&arg0.last_txs, &arg1)) {
            return 0x1::vector::empty<u8>()
        };
        *0x2::vec_map::get<u8, vector<u8>>(&arg0.last_txs, &arg1)
    }

    public(friend) fun new_clmm_market(arg0: &mut 0x2::object::UID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : CLMMMarket {
        CLMMMarket{
            id              : 0x2::derived_object::claim<vector<u8>>(arg0, b"CLMM_MARKET"),
            vault_id        : *0x2::object::uid_as_inner(arg0),
            coin_type_a     : arg1,
            coin_type_b     : arg2,
            certified_pools : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            position_keys   : 0x2::vec_set::empty<0x2::object::ID>(),
            positions       : 0x2::object_bag::new(arg3),
        }
    }

    public(friend) fun new_position(arg0: &mut CLMMMarket, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13836747549388046345);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1);
        let v2 = CLMMPosition{
            id       : 0x2::object::new(arg2),
            position : arg1,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v1);
        0x2::object_bag::add<0x2::object::ID, CLMMPosition>(&mut arg0.positions, v1, v2);
    }

    public fun position_id(arg0: &CLMMPosition) : 0x2::object::ID {
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)
    }

    public fun position_keys(arg0: &CLMMMarket) : 0x2::vec_set::VecSet<0x2::object::ID> {
        arg0.position_keys
    }

    public fun positions(arg0: &CLMMMarket) : &0x2::object_bag::ObjectBag {
        &arg0.positions
    }

    public(friend) fun remove_certified_pool<T0, T1>(arg0: &mut CLMMMarket, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13838999250418401303);
        let v1 = 0;
        let v2 = 0x2::vec_set::keys<0x2::object::ID>(&arg0.position_keys);
        while (v1 < 0x1::vector::length<0x2::object::ID>(v2)) {
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&borrow_position(arg0, *0x1::vector::borrow<0x2::object::ID>(v2, v1)).position) != v0, 13839280751165046809);
            v1 = v1 + 1;
        };
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.certified_pools, &v0);
    }

    public(friend) fun update_certified_pool(arg0: &mut CLMMMarket, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &arg1), 13836747523618242569);
        assert!(arg2 <= 10000, 13838717852750970901);
        *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.certified_pools, &arg1) = arg2;
    }

    fun update_last_tx(arg0: &mut CLMMPosition, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.last_txs, &arg1)) {
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut arg0.last_txs, &arg1) = *0x2::tx_context::digest(arg2);
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut arg0.last_txs, arg1, *0x2::tx_context::digest(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

