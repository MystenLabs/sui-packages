module 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::market_dlmm {
    struct DLMMMarket has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
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

    struct DLMMPositionCloseCertV2 {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        cert: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::ClosePositionCert,
    }

    public(friend) fun add_liquidity_on_bin<T0, T1>(arg0: &mut DLMMMarket, arg1: 0x2::object::ID, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinGroupRef, arg4: u8, arg5: u64, arg6: u64, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg1), 13835341003432787971);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg1), 13835341007727755267);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_liquidity_on_bin<T0, T1>(&mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg1).position, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun close_position<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (DLMMPositionCloseCert, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        abort 1
    }

    public(friend) fun collect_position_fee<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341424339582979);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341428634550275);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 3, arg5);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, &mut v0.position, arg3, arg4, arg5)
    }

    public(friend) fun collect_position_reward<T0, T1, T2>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341329850302467);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341334145269763);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 4, arg5);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, &mut v0.position, arg3, arg4, arg5)
    }

    public(friend) fun new_add_liquidity_cert<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: bool, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1> {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835340900353572867);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835340904648540163);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::new_add_liquidity_cert<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun remove_full_range_liquidity_by_percent<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u128, arg4: u128, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341531713765379);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341536008732675);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 2, arg8);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_full_range_liquidity_by_percent<T0, T1>(arg1, &mut v0.position, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: vector<u32>, arg4: vector<u128>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341789411803139);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341793706770435);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 1, arg8);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity<T0, T1>(arg1, &mut v0.position, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun remove_liquidity_by_percent<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: u16, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341660562784259);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341664857751555);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        update_last_tx(v0, 1, arg9);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity_by_percent<T0, T1>(arg1, &mut v0.position, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public(friend) fun repay_add_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341102217035779);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341106512003075);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6);
    }

    public fun pool_id(arg0: &DLMMPosition) : 0x2::object::ID {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg0.position)
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341218181152771);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341222476120067);
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::add_liquidity::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public(friend) fun add_certified_pool<T0, T1>(arg0: &mut DLMMMarket, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: u64) {
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.coin_type_a && 0x1::type_name::with_defining_ids<T1>() == arg0.coin_type_b || 0x1::type_name::with_defining_ids<T1>() == arg0.coin_type_a && 0x1::type_name::with_defining_ids<T0>() == arg0.coin_type_b, 13835058609332944897);
        assert!(!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13837310422032318477);
        assert!(arg2 <= 10000, 13838717801211363349);
        0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.certified_pools, v0, arg2);
    }

    public(friend) fun add_liquidity_bid_ask<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835342266153172995);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835342270448140291);
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::bid_ask::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public(friend) fun add_liquidity_curve<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835342102944415747);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835342107239383043);
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::curve::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public(friend) fun add_liquidity_spot<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835341939735658499);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835341944030625795);
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::spot::add_liquidity<T0, T1>(arg1, &mut 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2).position, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    fun amount_after_protocol_fee(arg0: u64, arg1: u64) : u64 {
        arg0 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(arg0, arg1, 10000)
    }

    public fun assert_dlmm_position_not_withdraw(arg0: &DLMMMarket, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(contain_position(arg0, arg1), 13835342833088856067);
        let v0 = 0x2::object_bag::borrow<0x2::object::ID, DLMMPosition>(&arg0.positions, arg1);
        assert!(last_tx(v0, 2) != *0x2::tx_context::digest(arg2), 13837876125059907599);
        assert!(last_tx(v0, 4) != *0x2::tx_context::digest(arg2), 13838157617216618513);
        assert!(last_tx(v0, 3) != *0x2::tx_context::digest(arg2), 13838439109373329427);
    }

    public fun borrow_position(arg0: &DLMMMarket, arg1: 0x2::object::ID) : &DLMMPosition {
        assert!(contain_position(arg0, arg1), 13835343430089310211);
        0x2::object_bag::borrow<0x2::object::ID, DLMMPosition>(&arg0.positions, arg1)
    }

    public(friend) fun calcualate_position_amounts<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        abort 1
    }

    public(friend) fun calculate_position_amounts_v2<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835342996297613315);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        assert!(pool_id(v0) == 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), 13835624479864389637);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::refresh_position_info<T0, T1>(arg1, arg2, arg3, arg5, arg6);
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let (v3, v4) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_amounts(&v1);
        let (v5, v6) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_fees(&v1);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::with_defining_ids<T0>(), v3 + amount_after_protocol_fee(v5, arg4));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::with_defining_ids<T1>(), v4 + amount_after_protocol_fee(v6, arg4));
        let v7 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::position_detail_rewards(&v1);
        let v8 = 0;
        while (v8 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(v7)) {
            let (v9, v10) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(v7, v8);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2, v9)) {
                let v11 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v2, v9);
                *v11 = *v11 + amount_after_protocol_fee(*v10, arg4);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, *v9, amount_after_protocol_fee(*v10, arg4));
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

    public fun check_pool_price_deviation<T0, T1>(arg0: &DLMMMarket, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::PythOracle, arg3: &0x2::clock::Clock) {
        let v0 = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::get_price<T0>(arg2, arg3);
        let v1 = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::get_price<T1>(arg2, arg3);
        let (v2, _) = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::calculate_prices_v2(&v0, &v1);
        let v4 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((10000 as u128), 0x1::u128::diff(v2, (get_current_pool_price_v2<T0, T1>(arg1) as u128)), v2) <= (*0x2::vec_map::get<0x2::object::ID, u64>(&arg0.certified_pools, &v4) as u128), 13837032069496700939);
    }

    public fun close_cert_position_id(arg0: &DLMMPositionCloseCert) : 0x2::object::ID {
        arg0.position_id
    }

    public fun close_cert_position_id_v2(arg0: &DLMMPositionCloseCertV2) : 0x2::object::ID {
        arg0.position_id
    }

    public(friend) fun close_position_v2<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (DLMMPositionCloseCertV2, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg2), 13835342395002191875);
        assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.positions, arg2), 13835342399297159171);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.position_keys, &arg2);
        let DLMMPosition {
            id       : v0,
            position : v1,
            amounts  : _,
            last_txs : _,
        } = 0x2::object_bag::remove<0x2::object::ID, DLMMPosition>(&mut arg0.positions, arg2);
        0x2::object::delete(v0);
        let (v4, v5, v6) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position<T0, T1>(arg1, v1, arg3, arg4, arg5, arg6);
        let v7 = DLMMPositionCloseCertV2{
            market_id   : 0x2::object::id<DLMMMarket>(arg0),
            position_id : arg2,
            cert        : v4,
        };
        (v7, v5, v6, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
    }

    public fun coin_types(arg0: &DLMMMarket) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public(friend) fun collect_reward_from_close_cert<T0, T1, T2>(arg0: &mut DLMMPositionCloseCert, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : 0x2::balance::Balance<T2> {
        abort 1
    }

    public(friend) fun collect_reward_from_close_cert_v2<T0, T1, T2>(arg0: &DLMMMarket, arg1: &mut DLMMPositionCloseCertV2, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : 0x2::balance::Balance<T2> {
        assert!(arg1.market_id == 0x2::object::id<DLMMMarket>(arg0), 13839283220771242009);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::take_reward_from_close_position_cert<T0, T1, T2>(arg2, &mut arg1.cert, arg3)
    }

    public fun contain_position(arg0: &DLMMMarket, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.position_keys, &arg1)
    }

    public(friend) fun destroy_close_cert(arg0: DLMMPositionCloseCert, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        abort 1
    }

    public(friend) fun destroy_close_cert_v2(arg0: &DLMMMarket, arg1: DLMMPositionCloseCertV2, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        let DLMMPositionCloseCertV2 {
            market_id   : v0,
            position_id : _,
            cert        : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<DLMMMarket>(arg0), 13839283280900784153);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v2, arg2);
    }

    public fun get_bin_price_from_oracle<T0, T1>(arg0: &0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::PythOracle, arg1: &0x2::clock::Clock) : u128 {
        let v0 = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::get_price<T0>(arg0, arg1);
        let v1 = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::get_price<T1>(arg0, arg1);
        let (v2, _) = 0xc426a7fdfe2d91d4492d977428a8dda1b182625a7907ff720897dd8b4848c330::pyth_oracle::calculate_prices_v2(&v0, &v1);
        (((v2 as u256) * 18446744073709551616 / (0x1::u128::pow(10, 20) as u256)) as u128)
    }

    public fun get_current_pool_price<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) : u64 {
        (((0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0)) as u256) * (0x1::u64::pow(10, 10) as u256) / 18446744073709551616) as u64)
    }

    public fun get_current_pool_price_v2<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) : u128 {
        (((0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0)) as u256) * (0x1::u128::pow(10, 20) as u256) / 18446744073709551616) as u128)
    }

    public(friend) fun last_amounts(arg0: &DLMMMarket, arg1: &0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0;
        while (v1 < 0x2::vec_set::length<0x2::object::ID>(&arg0.position_keys)) {
            let v2 = 0x2::object_bag::borrow<0x2::object::ID, DLMMPosition>(&arg0.positions, *0x1::vector::borrow<0x2::object::ID>(0x2::vec_set::keys<0x2::object::ID>(&arg0.position_keys), v1));
            assert!(last_tx(v2, 0) == *0x2::tx_context::digest(arg1), 13835905684258291719);
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

    public(friend) fun new_dlmm_market(arg0: &mut 0x2::object::UID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : DLMMMarket {
        DLMMMarket{
            id              : 0x2::derived_object::claim<vector<u8>>(arg0, b"DLMM_MARKET"),
            vault_id        : *0x2::object::uid_as_inner(arg0),
            coin_type_a     : arg1,
            coin_type_b     : arg2,
            certified_pools : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            position_keys   : 0x2::vec_set::empty<0x2::object::ID>(),
            positions       : 0x2::object_bag::new(arg3),
        }
    }

    public(friend) fun new_position(arg0: &mut DLMMMarket, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13836747613812555785);
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
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13836747923050201097);
        let v1 = 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::bid_ask::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v1);
        let v3 = DLMMPosition{
            id       : 0x2::object::new(arg13),
            position : v1,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v2);
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut arg0.positions, v2, v3);
        v2
    }

    public(friend) fun open_position_curve<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u16, arg8: u32, arg9: u32, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13836748112028762121);
        let v1 = 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::curve::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v1);
        let v3 = DLMMPosition{
            id       : 0x2::object::new(arg13),
            position : v1,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v2);
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut arg0.positions, v2, v3);
        v2
    }

    public(friend) fun open_position_spot<T0, T1>(arg0: &mut DLMMMarket, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u16, arg8: u32, arg9: u32, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13836747734071640073);
        let v1 = 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::spot::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v1);
        let v3 = DLMMPosition{
            id       : 0x2::object::new(arg13),
            position : v1,
            amounts  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_txs : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_keys, v2);
        0x2::object_bag::add<0x2::object::ID, DLMMPosition>(&mut arg0.positions, v2, v3);
        v2
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

    public(friend) fun remove_certified_pool<T0, T1>(arg0: &mut DLMMMarket, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) {
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &v0), 13838999314842910743);
        let v1 = 0;
        let v2 = 0x2::vec_set::keys<0x2::object::ID>(&arg0.position_keys);
        while (v1 < 0x1::vector::length<0x2::object::ID>(v2)) {
            assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&borrow_position(arg0, *0x1::vector::borrow<0x2::object::ID>(v2, v1)).position) != v0, 13839562290566397979);
            v1 = v1 + 1;
        };
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.certified_pools, &v0);
    }

    public(friend) fun update_certified_pool(arg0: &mut DLMMMarket, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.certified_pools, &arg1), 13836747588042752009);
        assert!(arg2 <= 10000, 13838717917175480341);
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

