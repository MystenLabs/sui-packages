module 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::market_dlmm {
    struct DLMMMarket has store, key {
        id: 0x2::object::UID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        certified_pools: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        position_keys: 0x2::vec_set::VecSet<0x2::object::ID>,
        positions: 0x2::object_bag::ObjectBag,
    }

    struct DLMMPosition has store, key {
        id: 0x2::object::UID,
        position: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position,
        amounts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        last_txs: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct DLMMPositionCloseCert {
        position_id: 0x2::object::ID,
        cert: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::ClosePositionCert,
    }

    struct PoolPriceDeviation has copy, drop {
        pool: 0x2::object::ID,
        allow_bin_deviation: u64,
        base_price: 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::Price,
        quote_price: 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::Price,
        pool_oracle_price: u64,
        pool_current_price: u64,
        diff: u64,
        derivation: u64,
    }

    public(friend) fun add_liquidity_on_bin<T0, T1>(arg0: &mut DLMMMarket, arg1: 0x2::object::ID, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinGroupRef, arg4: u8, arg5: u64, arg6: u64, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg1), 13835340801569325059);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg1), 13835340805864292355);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_liquidity_on_bin<T0, T1>(&mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg1).position, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun close_position<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (DLMMPositionCloseCert, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835342210318598147);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835342214613565443);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.position_keys, &arg2);
        let DLMMPosition {
            id       : v0,
            position : v1,
            amounts  : _,
            last_txs : _,
        } = 0x2::object_bag::remove<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        0x2::object::delete(v0);
        let (v4, v5, v6) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position<T0, T1>(arg1, v1, arg3, arg4, arg5, arg6);
        let v7 = DLMMPositionCloseCert{
            position_id : arg2,
            cert        : v4,
        };
        (v7, v5, v6)
    }

    public(friend) fun collect_position_fee<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341222476120067);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341226771087363);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 3, arg5);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, &mut v0.position, arg3, arg4, arg5)
    }

    public(friend) fun collect_position_reward<T0, T1, T2>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341127986839555);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341132281806851);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 4, arg5);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, &mut v0.position, arg3, arg4, arg5)
    }

    public(friend) fun new_add_liquidity_cert<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: bool, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1> {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835340698490109955);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835340702785077251);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::new_add_liquidity_cert<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: vector<u32>, arg4: vector<u128>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341604728209411);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341609023176707);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 1, arg8);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity<T0, T1>(arg1, &mut v0.position, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun remove_liquidity_by_percent<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: u16, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341475879190531);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341480174157827);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 1, arg9);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity_by_percent<T0, T1>(arg1, &mut v0.position, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public(friend) fun repay_add_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835340900353572867);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835340904648540163);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6);
    }

    public fun pool_id(arg0: &DLMMPosition) : 0x2::object::ID {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg0.position)
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341016317689859);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341020612657155);
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::add_liquidity::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public(friend) fun add_certified_pool<T0, T1>(arg0: &mut DLMMMarket, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: u64) {
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.coin_type_a && 0x1::type_name::with_defining_ids<T1>() == arg0.coin_type_b || 0x1::type_name::with_defining_ids<T1>() == arg0.coin_type_a && 0x1::type_name::with_defining_ids<T0>() == arg0.coin_type_b, 13835058501958762497);
        assert!(!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13837310314658136077);
        0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.certified_pools, v0, arg2);
    }

    public(friend) fun add_liquidity_bid_ask<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835342081469579267);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835342085764546563);
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::bid_ask::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public(friend) fun add_liquidity_curve<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341918260822019);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341922555789315);
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::curve::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public(friend) fun add_liquidity_spot<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341755052064771);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341759347032067);
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::spot::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun assert_dlmm_position_not_withdraw(arg0: &DLMMMarket, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(contain_position(arg0, arg1), 13835342510966308867);
        let v0 = 0x2::object_bag::borrow<0x2::object::ID, DLMMPosition>(&arg0.positions, arg1);
        assert!(last_tx(v0, 2) != *0x2::tx_context::digest(arg2), 13837875802937360399);
        assert!(last_tx(v0, 4) != *0x2::tx_context::digest(arg2), 13838157295094071313);
        assert!(last_tx(v0, 3) != *0x2::tx_context::digest(arg2), 13838438787250782227);
    }

    public fun borrow_position(arg0: &DLMMMarket, arg1: 0x2::object::ID) : &DLMMPosition {
        assert!(contain_position(arg0, arg1), 13835343133736566787);
        0x2::object_bag::borrow<0x2::object::ID, DLMMPosition>(&arg0.positions, arg1)
    }

    public(friend) fun calcualate_position_amounts<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835342618340491267);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        assert!(pool_id(v0) == 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), 13835624101907267589);
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
        let v12 = 0;
        if (0x2::vec_map::contains<u8, vector<u8>>(&v0.last_txs, &v12)) {
            let v13 = 0;
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut v0.last_txs, &v13) = *0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_update_tx(&v1);
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut v0.last_txs, 0, *0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_update_tx(&v1));
        };
    }

    public fun certified_pools(arg0: &DLMMMarket) : 0x2::vec_map::VecMap<0x2::object::ID, u64> {
        arg0.certified_pools
    }

    public fun check_pool_price_deviation<T0, T1>(arg0: &DLMMMarket, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::PythOracle, arg3: &0x2::clock::Clock) {
        let v0 = 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::get_price<T0>(arg2, arg3);
        let v1 = 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::get_price<T1>(arg2, arg3);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::price_value(&v0), 0x1::u64::pow(10, 10), 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::price_value(&v1));
        let v3 = get_current_pool_price<T0, T1>(arg1);
        let v4 = 0x1::u64::diff(v2, v3);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        let v6 = *0x2::vec_map::get<0x2::object::ID, u64>(&arg0.certified_pools, &v5);
        let v7 = PoolPriceDeviation{
            pool                : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            allow_bin_deviation : v6,
            base_price          : v0,
            quote_price         : v1,
            pool_oracle_price   : v2,
            pool_current_price  : v3,
            diff                : v4,
            derivation          : v6,
        };
        0x2::event::emit<PoolPriceDeviation>(v7);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(10000, v4, v2) <= v6, 13837031798913761291);
    }

    public fun close_cert_position_id(arg0: &DLMMPositionCloseCert) : 0x2::object::ID {
        arg0.position_id
    }

    public fun coin_types(arg0: &DLMMMarket) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public(friend) fun collect_reward_from_close_cert<T0, T1, T2>(arg0: &mut DLMMPositionCloseCert, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : 0x2::balance::Balance<T2> {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::take_reward_from_close_position_cert<T0, T1, T2>(arg1, &mut arg0.cert, arg2)
    }

    public fun contain_position(arg0: &DLMMMarket, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg1)
    }

    public(friend) fun destory_close_cert(arg0: DLMMPositionCloseCert, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        let DLMMPositionCloseCert {
            position_id : _,
            cert        : v1,
        } = arg0;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v1, arg1);
    }

    public fun get_bin_price_from_oracle<T0, T1>(arg0: &0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::PythOracle, arg1: &0x2::clock::Clock) : u128 {
        let v0 = 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::get_price<T0>(arg0, arg1);
        let v1 = 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::get_price<T1>(arg0, arg1);
        let (v2, _) = 0xa518c1a6e27d8ce5798d8a5a1128cdac585cb2145e234b5a04ca9de2c60a378b::pyth_oracle::calculate_prices(&v0, &v1);
        let v4 = (0x1::u64::pow(10, 30) as u256);
        (((v2 as u256) * v4 * 36893488147419103232 / v4) as u128)
    }

    public fun get_current_pool_price<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) : u64 {
        (((0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_bin<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0))) as u256) * (0x1::u64::pow(10, 10) as u256) / 36893488147419103232) as u64)
    }

    public(friend) fun last_amounts(arg0: &DLMMMarket, arg1: &0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0;
        while (v1 < 0x2::vec_set::length<0x2::object::ID>(&arg0.position_keys)) {
            let v2 = 0x2::object_bag::borrow<0x2::object::ID, DLMMPosition>(&arg0.positions, *0x1::vector::borrow<0x2::object::ID>(0x2::vec_set::keys<0x2::object::ID>(&arg0.position_keys), v1));
            assert!(last_tx(v2, 0) == *0x2::tx_context::digest(arg1), 13835905362135744519);
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

    public fun last_tx(arg0: &DLMMPosition, arg1: u8) : vector<u8> {
        if (!0x2::vec_map::contains<u8, vector<u8>>(&arg0.last_txs, &arg1)) {
            return 0x1::vector::empty<u8>()
        };
        *0x2::vec_map::get<u8, vector<u8>>(&arg0.last_txs, &arg1)
    }

    public(friend) fun new_dlmm_market(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: &mut 0x2::tx_context::TxContext) : DLMMMarket {
        DLMMMarket{
            id              : 0x2::object::new(arg2),
            coin_type_a     : arg0,
            coin_type_b     : arg1,
            certified_pools : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            position_keys   : 0x2::vec_set::empty<0x2::object::ID>(),
            positions       : 0x2::object_bag::new(arg2),
        }
    }

    public(friend) fun new_position(arg0: &mut DLMMMarket, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13836747424833994761);
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1);
        let v2 = DLMMPosition{
            id       : 0x2::object::new(arg2),
            position : arg1,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v1);
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut arg0.positions, v1, v2);
    }

    public(friend) fun open_position_bid_ask<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u16, arg8: u32, arg9: u32, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::bid_ask::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v0);
        let v2 = DLMMPosition{
            id       : 0x2::object::new(arg13),
            position : v0,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v1);
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut arg0.positions, v1, v2);
        v1
    }

    public(friend) fun open_position_curve<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u16, arg8: u32, arg9: u32, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::curve::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v0);
        let v2 = DLMMPosition{
            id       : 0x2::object::new(arg13),
            position : v0,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v1);
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut arg0.positions, v1, v2);
        v1
    }

    public(friend) fun open_position_spot<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u16, arg8: u32, arg9: u32, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::spot::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v0);
        let v2 = DLMMPosition{
            id       : 0x2::object::new(arg13),
            position : v0,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v1);
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut arg0.positions, v1, v2);
        v1
    }

    public fun position_id(arg0: &DLMMPosition) : 0x2::object::ID {
        0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position)
    }

    public fun position_keys(arg0: &DLMMMarket) : 0x2::vec_set::VecSet<0x2::object::ID> {
        arg0.position_keys
    }

    public fun positions(arg0: &DLMMMarket) : &0x2::object_bag::ObjectBag {
        &arg0.positions
    }

    public(friend) fun remove_full_range_liquidity_by_percent<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: u128, arg6: u128, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341342735204355);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341347030171651);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 2, arg10);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity_by_percent<T0, T1>(arg1, &mut v0.position, arg3, arg4, 0, arg7, arg8, arg9, arg10)
    }

    public(friend) fun update_certified_pool(arg0: &mut DLMMMarket, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &arg1), 13836747403359158281);
        *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.certified_pools, &arg1) = arg2;
    }

    fun update_last_tx(arg0: &mut DLMMPosition, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.last_txs, &arg1)) {
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut arg0.last_txs, &arg1) = *0x2::tx_context::digest(arg2);
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut arg0.last_txs, arg1, *0x2::tx_context::digest(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

