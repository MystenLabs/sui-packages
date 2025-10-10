module 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm {
    struct DLMMMarket has store, key {
        id: 0x2::object::UID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        certified_pools: 0x2::vec_map::VecMap<0x2::object::ID, u32>,
        position_keys: 0x2::vec_set::VecSet<0x2::object::ID>,
        positions: 0x2::object_bag::ObjectBag,
    }

    struct DLMMPosition has store, key {
        id: 0x2::object::UID,
        position: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position,
        amounts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        last_amounts_tx: vector<u8>,
    }

    struct DLMMPositionCloseCert {
        position_id: 0x2::object::ID,
        cert: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::ClosePositionCert,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x1b2a8b23bb8f8b397fd5dc550c115026096978f60a8ae3b5b1bb40271b74ec98::add_liquidity::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public(friend) fun add_certified_pool<T0, T1>(arg0: &mut DLMMMarket, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: u32) {
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.coin_type_a && 0x1::type_name::with_defining_ids<T1>() == arg0.coin_type_b || 0x1::type_name::with_defining_ids<T1>() == arg0.coin_type_a && 0x1::type_name::with_defining_ids<T0>() == arg0.coin_type_b, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::quote_type_error());
        assert!(!0x2::vec_map::contains<0x2::object::ID, u32>(&arg0.certified_pools, &v0), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::duplicate_certified_pool());
        0x2::vec_map::insert<0x2::object::ID, u32>(&mut arg0.certified_pools, v0, arg2);
    }

    public fun add_liquidity_bid_ask<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x1b2a8b23bb8f8b397fd5dc550c115026096978f60a8ae3b5b1bb40271b74ec98::bid_ask::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun add_liquidity_curve<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x1b2a8b23bb8f8b397fd5dc550c115026096978f60a8ae3b5b1bb40271b74ec98::curve::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun add_liquidity_on_bin<T0, T1>(arg0: &mut DLMMMarket, arg1: 0x2::object::ID, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinGroupRef, arg4: u8, arg5: u64, arg6: u64, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg1), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg1), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_liquidity_on_bin<T0, T1>(&mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg1).position, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun add_liquidity_spot<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x1b2a8b23bb8f8b397fd5dc550c115026096978f60a8ae3b5b1bb40271b74ec98::spot::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public(friend) fun calcualate_position_amounts<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        assert!(pool_id(v0) == 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::pool_not_match());
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::refresh_position_info<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let (v3, v4) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_amounts(&v1);
        let (v5, v6) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_fees(&v1);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::with_defining_ids<T0>(), v3 + v5);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::with_defining_ids<T1>(), v4 + v6);
        let v7 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_rewards(&v1);
        let v8 = 0;
        while (v8 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(v7)) {
            let (v9, v10) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(v7, v8);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2, v9)) {
                let v11 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v2, v9);
                *v11 = *v11 + *v10;
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, *v9, *v10);
            };
            v8 = v8 + 1;
        };
        v0.amounts = v2;
        v0.last_amounts_tx = *0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_update_tx(&v1);
    }

    public(friend) fun close_position<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (DLMMPositionCloseCert, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::duplicate_position());
        let DLMMPosition {
            id              : v0,
            position        : v1,
            amounts         : _,
            last_amounts_tx : _,
        } = 0x2::object_bag::remove<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        0x2::object::delete(v0);
        let (v4, v5, v6) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position<T0, T1>(arg1, v1, arg3, arg4, arg5, arg6);
        let v7 = DLMMPositionCloseCert{
            position_id : arg2,
            cert        : v4,
        };
        (v7, v5, v6)
    }

    public fun collect_position_fee<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5)
    }

    public fun collect_position_reward<T0, T1, T2>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5)
    }

    public(friend) fun collect_reward_from_close_cert<T0, T1, T2>(arg0: &mut DLMMPositionCloseCert, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : 0x2::balance::Balance<T2> {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::take_reward_from_close_position_cert<T0, T1, T2>(arg1, &mut arg0.cert, arg2)
    }

    public(friend) fun destory_close_cert(arg0: DLMMPositionCloseCert, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        let DLMMPositionCloseCert {
            position_id : _,
            cert        : v1,
        } = arg0;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v1, arg1);
    }

    public(friend) fun last_amounts(arg0: &DLMMMarket, arg1: &0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0;
        while (v1 < 0x2::vec_set::length<0x2::object::ID>(&arg0.position_keys)) {
            let v2 = 0x2::object_bag::borrow<0x2::object::ID, DLMMPosition>(&arg0.positions, *0x1::vector::borrow<0x2::object::ID>(0x2::vec_set::keys<0x2::object::ID>(&arg0.position_keys), v1));
            assert!(v2.last_amounts_tx == *0x2::tx_context::digest(arg1), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_amounts_not_calculated());
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

    public fun new_add_liquidity_cert<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: bool, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1> {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::new_add_liquidity_cert<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun new_dlmm_market<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : DLMMMarket {
        DLMMMarket{
            id              : 0x2::object::new(arg0),
            coin_type_a     : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_b     : 0x1::type_name::with_defining_ids<T1>(),
            certified_pools : 0x2::vec_map::empty<0x2::object::ID, u32>(),
            position_keys   : 0x2::vec_set::empty<0x2::object::ID>(),
            positions       : 0x2::object_bag::new(arg0),
        }
    }

    public(friend) fun new_position(arg0: &mut DLMMMarket, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u32>(&arg0.certified_pools, &v0), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::uncertified_pool());
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &v1), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::duplicate_position());
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1);
        let v3 = DLMMPosition{
            id              : 0x2::object::new(arg2),
            position        : arg1,
            amounts         : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_amounts_tx : 0x1::vector::empty<u8>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v2);
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut arg0.positions, v2, v3);
    }

    public fun pool_id(arg0: &DLMMPosition) : 0x2::object::ID {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg0.position)
    }

    public fun position_id(arg0: &DLMMPosition) : 0x2::object::ID {
        0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: vector<u32>, arg4: vector<u128>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun remove_liquidity_by_percent<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: u16, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity_by_percent<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun repay_add_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::position_not_found());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

