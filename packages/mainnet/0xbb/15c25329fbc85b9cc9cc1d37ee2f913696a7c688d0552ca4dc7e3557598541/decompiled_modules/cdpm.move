module 0xbb15c25329fbc85b9cc9cc1d37ee2f913696a7c688d0552ca4dc7e3557598541::cdpm {
    struct AccessList has key {
        id: 0x2::object::UID,
        allow: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct FeeHouse has key {
        id: 0x2::object::UID,
        fee_rate: u64,
        fee: 0x2::bag::Bag,
    }

    struct PositionManager has key {
        id: 0x2::object::UID,
        owner: address,
        agents: 0x2::vec_set::VecSet<address>,
        position: 0x1::option::Option<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>,
        balance: 0x2::bag::Bag,
        fee: 0x2::bag::Bag,
    }

    struct GlobalRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Record has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct PositionManagerCreated has copy, drop {
        pm_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
        lower_bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_bin_id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_shares: vector<u128>,
    }

    struct PositionExtract has copy, drop {
        pm_id: 0x2::object::ID,
        owner: address,
    }

    struct PositionManagerClosed has copy, drop {
        pm_id: 0x2::object::ID,
        owner: address,
    }

    struct LiquidityAdded has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bins: vector<u32>,
        amount_a: u64,
        amount_b: u64,
        by: address,
    }

    struct LiquidityRemoved has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bins: vector<u32>,
        liquidity_shares: vector<u128>,
        amount_a: u64,
        amount_b: u64,
        by: address,
    }

    struct FeeCollected has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::ascii::String,
        coin_type_b: 0x1::ascii::String,
        amount_a: u64,
        amount_b: u64,
        by: address,
    }

    struct RewardCollected has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        by: address,
    }

    struct ProtocolFeeCollected has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::ascii::String,
        coin_type_b: 0x1::ascii::String,
        amount_a: u64,
        amount_b: u64,
        fee_a: u64,
        fee_b: u64,
    }

    struct ProtocolRewardCollected has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        fee_amount: u64,
    }

    struct BalanceDeposited has copy, drop {
        pm_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct BalanceWithdrawn has copy, drop {
        pm_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct UserFeeWithdrawn has copy, drop {
        pm_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct AdminFeeCollected has copy, drop {
        fee_house_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        admin: address,
    }

    struct FeeTransferredToBalance has copy, drop {
        pm_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct AgentAdded has copy, drop {
        pm_id: 0x2::object::ID,
        agent: address,
    }

    struct AgentRemoved has copy, drop {
        pm_id: 0x2::object::ID,
        agent: address,
    }

    struct FeeRateUpdated has copy, drop {
        fee_house_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct AccessGranted has copy, drop {
        access_list_id: 0x2::object::ID,
        address: address,
    }

    struct AccessRevoked has copy, drop {
        access_list_id: 0x2::object::ID,
        address: address,
    }

    struct AdminTransferred has copy, drop {
        from: address,
        to: address,
    }

    struct RecordCreated has copy, drop {
        record_id: 0x2::object::ID,
        owner: address,
    }

    struct RecordDeleted has copy, drop {
        record_id: 0x2::object::ID,
        owner: address,
    }

    struct ProtocolLiquidityAdded has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bins: vector<u32>,
        amount_a: u64,
        amount_b: u64,
        by: address,
    }

    struct ProtocolLiquidityRemoved has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bins: vector<u32>,
        liquidity_shares: vector<u128>,
        amount_a: u64,
        amount_b: u64,
        by: address,
    }

    struct AgentLiquidityAdded has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bins: vector<u32>,
        amount_a: u64,
        amount_b: u64,
        by: address,
    }

    struct AgentLiquidityRemoved has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bins: vector<u32>,
        liquidity_shares: vector<u128>,
        amount_a: u64,
        amount_b: u64,
        by: address,
    }

    struct AgentFeeCollected has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::ascii::String,
        coin_type_b: 0x1::ascii::String,
        amount_a: u64,
        amount_b: u64,
        by: address,
    }

    struct AgentRewardCollected has copy, drop {
        pm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        by: address,
    }

    fun add_liquidity_private<T0, T1>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_liquidity<T0, T1>(arg1, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts<T0, T1>(&v0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_add_liquidity<T0, T1>(arg1, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position), v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v1, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v2, arg10)), arg8);
        (v1, v2)
    }

    fun add_to_balance<T0>(arg0: &mut PositionManager, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.balance, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun add_to_fee<T0>(arg0: &mut PositionManager, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.fee, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.fee, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.fee, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun admin_collect_fee<T0>(arg0: &AdminCap, arg1: &mut FeeHouse, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.fee, v0), arg2);
        let v2 = AdminFeeCollected{
            fee_house_id : 0x2::object::id<FeeHouse>(arg1),
            coin_type    : v0,
            amount       : 0x2::coin::value<T0>(&v1),
            admin        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminFeeCollected>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun admin_collect_fee_return_coin<T0>(arg0: &AdminCap, arg1: &mut FeeHouse, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.fee, v0), arg2);
        let v2 = AdminFeeCollected{
            fee_house_id : 0x2::object::id<FeeHouse>(arg1),
            coin_type    : v0,
            amount       : 0x2::coin::value<T0>(&v1),
            admin        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminFeeCollected>(v2);
        v1
    }

    public fun admin_insert_access_list(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.allow, arg2);
        let v0 = AccessGranted{
            access_list_id : 0x2::object::id<AccessList>(arg1),
            address        : arg2,
        };
        0x2::event::emit<AccessGranted>(v0);
    }

    public fun admin_remove_access_list(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.allow, &arg2);
        let v0 = AccessRevoked{
            access_list_id : 0x2::object::id<AccessList>(arg1),
            address        : arg2,
        };
        0x2::event::emit<AccessRevoked>(v0);
    }

    public fun admin_set_fee(arg0: &AdminCap, arg1: &mut FeeHouse, arg2: u64) {
        assert!((arg2 as u128) <= 3000, 1003);
        arg1.fee_rate = arg2;
        let v0 = FeeRateUpdated{
            fee_house_id : 0x2::object::id<FeeHouse>(arg1),
            old_fee_rate : arg1.fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<FeeRateUpdated>(v0);
    }

    public fun admin_transfer(arg0: AdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = AdminTransferred{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun agent_add_liquidity<T0, T1>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x2::vec_set::contains<address>(&arg0.agents, &v0), 1002);
        let v1 = withdraw_from_balance<T0>(arg0, arg2, arg10);
        let v2 = withdraw_from_balance<T1>(arg0, arg3, arg10);
        let v3 = &mut v1;
        let v4 = &mut v2;
        let (v5, v6) = add_liquidity_private<T0, T1>(arg0, arg1, v3, v4, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        add_to_balance<T0>(arg0, v1);
        add_to_balance<T1>(arg0, v2);
        let v7 = AgentLiquidityAdded{
            pm_id    : 0x2::object::id<PositionManager>(arg0),
            pool_id  : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            bins     : arg4,
            amount_a : v5,
            amount_b : v6,
            by       : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<AgentLiquidityAdded>(v7);
    }

    public fun agent_collect_fee<T0, T1>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.agents, &v0), 1002);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position), arg2, arg3, arg4);
        let v3 = v2;
        let v4 = v1;
        add_to_fee<T0>(arg0, 0x2::coin::from_balance<T0>(v4, arg4));
        add_to_fee<T1>(arg0, 0x2::coin::from_balance<T1>(v3, arg4));
        let v5 = AgentFeeCollected{
            pm_id       : 0x2::object::id<PositionManager>(arg0),
            pool_id     : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            coin_type_a : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_type_b : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            amount_a    : 0x2::balance::value<T0>(&v4),
            amount_b    : 0x2::balance::value<T1>(&v3),
            by          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AgentFeeCollected>(v5);
    }

    public fun agent_collect_reward<T0, T1, T2>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.agents, &v0), 1002);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position), arg2, arg3, arg4);
        add_to_fee<T2>(arg0, 0x2::coin::from_balance<T2>(v1, arg4));
        let v2 = AgentRewardCollected{
            pm_id     : 0x2::object::id<PositionManager>(arg0),
            pool_id   : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
            amount    : 0x2::balance::value<T2>(&v1),
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AgentRewardCollected>(v2);
    }

    public fun agent_remove_liquidity<T0, T1>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: vector<u32>, arg3: vector<u128>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg0.agents, &v0), 1002);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity<T0, T1>(arg1, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position), arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        add_to_balance<T0>(arg0, 0x2::coin::from_balance<T0>(v4, arg7));
        add_to_balance<T1>(arg0, 0x2::coin::from_balance<T1>(v3, arg7));
        let v5 = AgentLiquidityRemoved{
            pm_id            : 0x2::object::id<PositionManager>(arg0),
            pool_id          : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            bins             : arg2,
            liquidity_shares : arg3,
            amount_a         : 0x2::balance::value<T0>(&v4),
            amount_b         : 0x2::balance::value<T1>(&v3),
            by               : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<AgentLiquidityRemoved>(v5);
    }

    public fun agent_transfer_fee_to_balance<T0>(arg0: &mut PositionManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.agents, &v0), 1002);
        let v1 = withdraw_from_fee<T0>(arg0, arg1, arg2);
        add_to_balance<T0>(arg0, v1);
        let v2 = FeeTransferredToBalance{
            pm_id     : 0x2::object::id<PositionManager>(arg0),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<FeeTransferredToBalance>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeHouse{
            id       : 0x2::object::new(arg0),
            fee_rate : 2000,
            fee      : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<FeeHouse>(v1);
        let v2 = AccessList{
            id    : 0x2::object::new(arg0),
            allow : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<AccessList>(v2);
        let v3 = GlobalRecord{
            id     : 0x2::object::new(arg0),
            record : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<GlobalRecord>(v3);
    }

    public fun protocol_add_liquidity<T0, T1>(arg0: &AccessList, arg1: &mut PositionManager, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1002);
        assert!(0x2::vec_set::is_empty<address>(&arg1.agents), 1002);
        let v1 = withdraw_from_balance<T0>(arg1, arg3, arg11);
        let v2 = withdraw_from_balance<T1>(arg1, arg4, arg11);
        let v3 = &mut v1;
        let v4 = &mut v2;
        let (v5, v6) = add_liquidity_private<T0, T1>(arg1, arg2, v3, v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        add_to_balance<T0>(arg1, v1);
        add_to_balance<T1>(arg1, v2);
        let v7 = ProtocolLiquidityAdded{
            pm_id    : 0x2::object::id<PositionManager>(arg1),
            pool_id  : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg2),
            bins     : arg5,
            amount_a : v5,
            amount_b : v6,
            by       : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<ProtocolLiquidityAdded>(v7);
    }

    public fun protocol_collect_fee<T0, T1>(arg0: &AccessList, arg1: &mut FeeHouse, arg2: &mut PositionManager, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1002);
        assert!(0x2::vec_set::is_empty<address>(&arg2.agents), 1002);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg3, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg2.position), arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        take_fee<T0>(v5, arg1);
        let v6 = &mut v3;
        take_fee<T1>(v6, arg1);
        let v7 = 0x2::balance::value<T0>(&v4);
        let v8 = 0x2::balance::value<T1>(&v3);
        add_to_fee<T0>(arg2, 0x2::coin::from_balance<T0>(v4, arg6));
        add_to_fee<T1>(arg2, 0x2::coin::from_balance<T1>(v3, arg6));
        let v9 = ProtocolFeeCollected{
            pm_id       : 0x2::object::id<PositionManager>(arg2),
            pool_id     : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg3),
            coin_type_a : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_type_b : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            amount_a    : v7,
            amount_b    : v8,
            fee_a       : 0x2::balance::value<T0>(&v4) - v7,
            fee_b       : 0x2::balance::value<T1>(&v3) - v8,
        };
        0x2::event::emit<ProtocolFeeCollected>(v9);
    }

    public fun protocol_collect_reward<T0, T1, T2>(arg0: &AccessList, arg1: &mut FeeHouse, arg2: &mut PositionManager, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1002);
        assert!(0x2::vec_set::is_empty<address>(&arg2.agents), 1002);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg3, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg2.position), arg4, arg5, arg6);
        let v2 = &mut v1;
        take_fee<T2>(v2, arg1);
        let v3 = 0x2::balance::value<T2>(&v1);
        add_to_fee<T2>(arg2, 0x2::coin::from_balance<T2>(v1, arg6));
        let v4 = ProtocolRewardCollected{
            pm_id      : 0x2::object::id<PositionManager>(arg2),
            pool_id    : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg3),
            coin_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
            amount     : v3,
            fee_amount : 0x2::balance::value<T2>(&v1) - v3,
        };
        0x2::event::emit<ProtocolRewardCollected>(v4);
    }

    public fun protocol_remove_liquidity<T0, T1>(arg0: &AccessList, arg1: &mut PositionManager, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: vector<u32>, arg4: vector<u128>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1002);
        assert!(0x2::vec_set::is_empty<address>(&arg1.agents), 1002);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity<T0, T1>(arg2, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg1.position), arg3, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        add_to_balance<T0>(arg1, 0x2::coin::from_balance<T0>(v4, arg8));
        add_to_balance<T1>(arg1, 0x2::coin::from_balance<T1>(v3, arg8));
        let v5 = ProtocolLiquidityRemoved{
            pm_id            : 0x2::object::id<PositionManager>(arg1),
            pool_id          : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg2),
            bins             : arg3,
            liquidity_shares : arg4,
            amount_a         : 0x2::balance::value<T0>(&v4),
            amount_b         : 0x2::balance::value<T1>(&v3),
            by               : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<ProtocolLiquidityRemoved>(v5);
    }

    public fun protocol_transfer_fee_to_balance<T0>(arg0: &AccessList, arg1: &mut PositionManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1002);
        assert!(0x2::vec_set::is_empty<address>(&arg1.agents), 1002);
        let v1 = withdraw_from_fee<T0>(arg1, arg2, arg3);
        add_to_balance<T0>(arg1, v1);
        let v2 = FeeTransferredToBalance{
            pm_id     : 0x2::object::id<PositionManager>(arg1),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<FeeTransferredToBalance>(v2);
    }

    public fun register_and_return_record(arg0: &mut GlobalRecord, arg1: &mut 0x2::tx_context::TxContext) : Record {
        let v0 = Record{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        let v1 = 0x2::object::id<Record>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.record, 0x2::tx_context::sender(arg1), v1);
        let v2 = RecordCreated{
            record_id : v1,
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RecordCreated>(v2);
        v0
    }

    fun take_fee<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut FeeHouse) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg1.fee, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.fee, v0), 0x2::balance::split<T0>(arg0, (((0x2::balance::value<T0>(arg0) as u128) * (arg1.fee_rate as u128) / 10000) as u64)));
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.fee, v0, 0x2::balance::split<T0>(arg0, (((0x2::balance::value<T0>(arg0) as u128) * (arg1.fee_rate as u128) / 10000) as u64)));
        };
    }

    public fun transfer_record(arg0: Record, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Record>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun unregister_record(arg0: &mut GlobalRecord, arg1: Record, arg2: &0x2::tx_context::TxContext) {
        let Record {
            id     : v0,
            record : v1,
        } = arg1;
        0x2::table::destroy_empty<0x2::object::ID, bool>(v1);
        0x2::object::delete(v0);
        let v2 = RecordDeleted{
            record_id : 0x2::table::remove<address, 0x2::object::ID>(&mut arg0.record, 0x2::tx_context::sender(arg2)),
            owner     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RecordDeleted>(v2);
    }

    public fun user_add_liquidity_to_balance<T0>(arg0: &mut PositionManager, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1001);
        add_to_balance<T0>(arg0, arg1);
        let v0 = BalanceDeposited{
            pm_id     : 0x2::object::id<PositionManager>(arg0),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<BalanceDeposited>(v0);
    }

    public fun user_add_liquidity_to_position<T0, T1>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg10), 1001);
        let (v0, v1) = add_liquidity_private<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = LiquidityAdded{
            pm_id    : 0x2::object::id<PositionManager>(arg0),
            pool_id  : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            bins     : arg4,
            amount_a : v0,
            amount_b : v1,
            by       : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<LiquidityAdded>(v2);
    }

    public fun user_close_pm<T0, T1>(arg0: &mut Record, arg1: PositionManager, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg6), 1001);
        let v0 = 0x2::object::id<PositionManager>(&arg1);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.record, v0);
        let PositionManager {
            id       : v1,
            owner    : v2,
            agents   : _,
            position : v4,
            balance  : v5,
            fee      : v6,
        } = arg1;
        let v7 = v4;
        if (0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v7)) {
            let (v8, v9, v10) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position<T0, T1>(arg2, 0x1::option::destroy_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v7), arg3, arg4, arg5, arg6);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v8, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg6), 0x2::tx_context::sender(arg6));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v10, arg6), 0x2::tx_context::sender(arg6));
        } else {
            0x1::option::destroy_none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v7);
        };
        0x2::bag::destroy_empty(v5);
        0x2::bag::destroy_empty(v6);
        0x2::object::delete(v1);
        let v11 = PositionManagerClosed{
            pm_id : v0,
            owner : v2,
        };
        0x2::event::emit<PositionManagerClosed>(v11);
    }

    public fun user_collect_fee<T0, T1>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1001);
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position), arg2, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = FeeCollected{
            pm_id       : 0x2::object::id<PositionManager>(arg0),
            pool_id     : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            coin_type_a : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_type_b : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            amount_a    : 0x2::balance::value<T0>(&v3),
            amount_b    : 0x2::balance::value<T1>(&v2),
            by          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeeCollected>(v4);
        (0x2::coin::from_balance<T0>(v3, arg4), 0x2::coin::from_balance<T1>(v2, arg4))
    }

    public fun user_collect_reward<T0, T1, T2>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1001);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position), arg2, arg3, arg4);
        let v1 = RewardCollected{
            pm_id     : 0x2::object::id<PositionManager>(arg0),
            pool_id   : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
            amount    : 0x2::balance::value<T2>(&v0),
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RewardCollected>(v1);
        0x2::coin::from_balance<T2>(v0, arg4)
    }

    public fun user_deposit_liquidity<T0, T1>(arg0: &mut Record, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg1, &mut v3, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v4, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v5, arg10)), arg8);
        let v6 = PositionManager{
            id       : 0x2::object::new(arg10),
            owner    : 0x2::tx_context::sender(arg10),
            agents   : 0x2::vec_set::empty<address>(),
            position : 0x1::option::some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v3),
            balance  : 0x2::bag::new(arg10),
            fee      : 0x2::bag::new(arg10),
        };
        let v7 = 0x2::object::id<PositionManager>(&v6);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.record, v7, true);
        0x2::transfer::share_object<PositionManager>(v6);
        let v8 = PositionManagerCreated{
            pm_id            : v7,
            owner            : 0x2::tx_context::sender(arg10),
            pool_id          : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            lower_bin_id     : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(&v3),
            upper_bin_id     : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(&v3),
            liquidity_shares : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_shares(&v3),
        };
        0x2::event::emit<PositionManagerCreated>(v8);
    }

    public fun user_deposit_position(arg0: &mut Record, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionManager{
            id       : 0x2::object::new(arg2),
            owner    : 0x2::tx_context::sender(arg2),
            agents   : 0x2::vec_set::empty<address>(),
            position : 0x1::option::some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg1),
            balance  : 0x2::bag::new(arg2),
            fee      : 0x2::bag::new(arg2),
        };
        let v1 = 0x2::object::id<PositionManager>(&v0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.record, v1, true);
        0x2::transfer::share_object<PositionManager>(v0);
        let v2 = PositionManagerCreated{
            pm_id            : v1,
            owner            : 0x2::tx_context::sender(arg2),
            pool_id          : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg1),
            lower_bin_id     : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(&arg1),
            upper_bin_id     : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(&arg1),
            liquidity_shares : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_shares(&arg1),
        };
        0x2::event::emit<PositionManagerCreated>(v2);
    }

    public fun user_get_and_return_position(arg0: &mut PositionManager, arg1: &0x2::tx_context::TxContext) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1001);
        let v0 = PositionExtract{
            pm_id : 0x2::object::id<PositionManager>(arg0),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PositionExtract>(v0);
        0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position)
    }

    public fun user_get_position(arg0: &mut PositionManager, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(user_get_and_return_position(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun user_insert_agent(arg0: &mut PositionManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1001);
        0x2::vec_set::insert<address>(&mut arg0.agents, arg1);
        let v0 = AgentAdded{
            pm_id : 0x2::object::id<PositionManager>(arg0),
            agent : arg1,
        };
        0x2::event::emit<AgentAdded>(v0);
    }

    public fun user_remove_agent(arg0: &mut PositionManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1001);
        0x2::vec_set::remove<address>(&mut arg0.agents, &arg1);
        let v0 = AgentRemoved{
            pm_id : 0x2::object::id<PositionManager>(arg0),
            agent : arg1,
        };
        0x2::event::emit<AgentRemoved>(v0);
    }

    public fun user_remove_liquidity_from_balance<T0>(arg0: &mut PositionManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1001);
        let v0 = withdraw_from_balance<T0>(arg0, arg1, arg2);
        let v1 = BalanceWithdrawn{
            pm_id     : 0x2::object::id<PositionManager>(arg0),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<BalanceWithdrawn>(v1);
        v0
    }

    public fun user_remove_liquidity_from_position<T0, T1>(arg0: &mut PositionManager, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: vector<u32>, arg3: vector<u128>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg7), 1001);
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity<T0, T1>(arg1, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position), arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = LiquidityRemoved{
            pm_id            : 0x2::object::id<PositionManager>(arg0),
            pool_id          : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            bins             : arg2,
            liquidity_shares : arg3,
            amount_a         : 0x2::balance::value<T0>(&v3),
            amount_b         : 0x2::balance::value<T1>(&v2),
            by               : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<LiquidityRemoved>(v4);
        (0x2::coin::from_balance<T0>(v3, arg7), 0x2::coin::from_balance<T1>(v2, arg7))
    }

    public fun user_withdraw_fee<T0>(arg0: &mut PositionManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1001);
        let v0 = withdraw_from_fee<T0>(arg0, arg1, arg2);
        let v1 = UserFeeWithdrawn{
            pm_id     : 0x2::object::id<PositionManager>(arg0),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<UserFeeWithdrawn>(v1);
        v0
    }

    fun withdraw_from_balance<T0>(arg0: &mut PositionManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (arg1 >= 0x2::balance::value<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0))) {
            0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0), arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0), arg1), arg2)
        }
    }

    fun withdraw_from_fee<T0>(arg0: &mut PositionManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (arg1 >= 0x2::balance::value<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.fee, v0))) {
            0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.fee, v0), arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.fee, v0), arg1), arg2)
        }
    }

    // decompiled from Move bytecode v7
}

