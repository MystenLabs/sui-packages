module 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::liquidity {
    struct OpenPositionEvent has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        sender: address,
        position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct ClosePositionEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct CollectFeeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        recipient: address,
        sender: address,
        fee_a: u64,
        fee_b: u64,
    }

    struct CollectRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        recipient: address,
        sender: address,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct PositionUnwind {
        adapter_version: u64,
        pool_id: 0x2::object::ID,
        nft: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        ticket: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::UnwindTicket,
        waived: vector<u64>,
    }

    struct ObserveRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        pocket_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        unpayable_since: 0x1::option::Option<u64>,
        payable_since: 0x1::option::Option<u64>,
    }

    struct AbandonPositionEvent has copy, drop {
        pool_id: 0x2::object::ID,
        pocket_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        recipient: address,
        reward_types: vector<0x1::type_name::TypeName>,
        rewards_owed: vector<u64>,
    }

    public fun report_unreadable<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_unreadable<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_object(0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2), arg3), evidence_reason(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_remove_liquidity<T1, T2>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T1, T2>(arg2, arg3)), arg4, arg5)
    }

    public fun close_position<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit());
        let v1 = &mut v0;
        let v2 = lend<T0, T1, T2>(arg1, v1, arg2, arg6, arg7);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v2);
        if (v3 > 0) {
            let v4 = &mut v0;
            let v5 = &mut v2;
            let (v6, v7) = remove<T0, T1, T2>(arg1, v4, arg5, arg6, v5, v3, arg8, arg9, arg10);
            let v8 = if (arg8 > 0) {
                true
            } else if (arg9 > 0) {
                true
            } else {
                v6 == 0 && v7 == 0
            };
            assert!(v8, 207);
        };
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_collect_fee<T1, T2>(arg6)) {
            let v9 = &mut v0;
            collect<T0, T1, T2>(arg1, v9, arg5, arg6, &v2, true, arg11);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T2>(arg5, arg6, v2);
        let v10 = ClosePositionEvent{
            pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6),
            position_id : arg7,
        };
        0x2::event::emit<ClosePositionEvent>(v10);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::discard_object<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, &mut v0);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, arg3, v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6)));
    }

    public fun collect_fee<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: 0x2::object::ID, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit());
        let v1 = &mut v0;
        let v2 = lend<T0, T1, T2>(arg1, v1, arg2, arg6, arg7);
        let v3 = &mut v0;
        collect<T0, T1, T2>(arg1, v3, arg5, arg6, &v2, arg8, arg9);
        let v4 = &mut v0;
        give_back<T0>(arg1, v4, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, arg3, v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6)));
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: 0x2::object::ID, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit());
        let v1 = &mut v0;
        let v2 = lend<T0, T1, T2>(arg1, v1, arg2, arg6, arg7);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T2, T3>(arg5, arg6, &v2, arg8, arg9, arg10);
        if (0x2::balance::value<T3>(&v3) > 0) {
            let v4 = 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>>(arg1);
            let v5 = CollectRewardEvent{
                pool_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6),
                position_id   : arg7,
                recipient     : 0x2::object::id_to_address(&v4),
                sender        : 0x2::tx_context::sender(arg11),
                reward_type   : 0x1::type_name::with_defining_ids<T3>(),
                reward_amount : 0x2::balance::value<T3>(&v3),
            };
            0x2::event::emit<CollectRewardEvent>(v5);
        };
        let v6 = &mut v0;
        give_back<T0>(arg1, v6, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put_reward<T0, T3, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, arg4, &mut v0, v3, arg11);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, arg3, v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6)));
    }

    public fun open_position<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: u32, arg9: u32, arg10: u64, arg11: bool, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_add(arg10, arg13);
        assert_near_book<T0, T1, T2>(arg1, arg5, arg4, arg7);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter());
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T2>(arg6, arg7, arg8, arg9, arg15);
        let v2 = 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>>(arg1);
        let v3 = OpenPositionEvent{
            pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg7),
            owner       : 0x2::object::id_to_address(&v2),
            sender      : 0x2::tx_context::sender(arg15),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            tick_lower  : arg8,
            tick_upper  : arg9,
        };
        0x2::event::emit<OpenPositionEvent>(v3);
        let v4 = &mut v0;
        let v5 = &mut v1;
        add<T0, T1, T2>(arg1, v4, arg6, arg7, v5, arg10, arg11, arg12, arg13, arg14);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v1);
        let v8 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::type_name::TypeName>(v9, 0x1::type_name::with_defining_ids<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v9, 0x1::type_name::with_defining_ids<T2>());
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::store_object<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, &mut v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg7), v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v7), v8);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, arg3, v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg7)));
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1)
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: 0x2::object::ID, arg8: u128, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 201);
        assert_floor(arg9, arg10);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit());
        let v1 = &mut v0;
        let v2 = lend<T0, T1, T2>(arg1, v1, arg2, arg6, arg7);
        let v3 = &mut v0;
        let v4 = &mut v2;
        let (_, _) = remove<T0, T1, T2>(arg1, v3, arg5, arg6, v4, arg8, arg9, arg10, arg11);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_collect_fee<T1, T2>(arg6)) {
            let v7 = &mut v0;
            collect<T0, T1, T2>(arg1, v7, arg5, arg6, &v2, true, arg12);
        };
        let v8 = &mut v0;
        give_back<T0>(arg1, v8, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, arg3, v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6)));
    }

    public fun abandon_unwind_position<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: PositionUnwind, arg4: &0x2::clock::Clock) {
        let (v0, v1) = end_position_unwind<T0, T1, T2>(arg0, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = &v2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(v4)) {
            let v6 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_marked_since<T0>(arg0, *0x1::vector::borrow<u64>(v4, v5));
            let v7 = &v6;
            assert!(0x1::option::is_some<u64>(v7) && 0x2::clock::timestamp_ms(arg4) >= *0x1::option::borrow<u64>(v7) + 604800000, 212);
            v5 = v5 + 1;
        };
        let v8 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v3);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_fee<T1, T2>(arg2, v8);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_rewards<T1, T2>(arg2, v8);
        assert_abandonable(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v3), v9, v10, &v11, &v2);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarders(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T1, T2>(arg2));
        let v13 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v14 = vector[];
        let v15 = 0;
        while (v15 < 0x1::vector::length<u64>(&v11)) {
            if (*0x1::vector::borrow<u64>(&v11, v15) > 0) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::reward_coin(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v12, v15)));
                0x1::vector::push_back<u64>(&mut v14, *0x1::vector::borrow<u64>(&v11, v15));
            };
            v15 = v15 + 1;
        };
        let v16 = 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::lno_address(arg1);
        let v17 = AbandonPositionEvent{
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2),
            pocket_id    : 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>>(arg0),
            position_id  : v8,
            recipient    : v16,
            reward_types : v13,
            rewards_owed : v14,
        };
        0x2::event::emit<AbandonPositionEvent>(v17);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v3, v16);
    }

    fun add<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: u64, arg6: bool, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) {
        let (v0, v1) = if (arg6) {
            (arg5, arg7)
        } else {
            (arg7, arg5)
        };
        let v2 = take_some<T0, T1>(arg0, arg1, v0);
        let v3 = take_some<T0, T2>(arg0, arg1, v1);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg9);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T2>(&v4);
        let v7 = if (arg6) {
            v6
        } else {
            v5
        };
        assert!(v7 <= arg7, 202);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T2>(arg2, arg3, 0x2::balance::split<T1>(&mut v2, v5), 0x2::balance::split<T2>(&mut v3, v6), v4);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg4) - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg4);
        assert!(v8 >= arg8, 203);
        let v9 = AddLiquidityEvent{
            pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3),
            position_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4),
            liquidity_delta : v8,
            amount_a        : v5,
            amount_b        : v6,
        };
        0x2::event::emit<AddLiquidityEvent>(v9);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, v3);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: 0x2::object::ID, arg9: u64, arg10: bool, arg11: u64, arg12: u128, arg13: &0x2::clock::Clock) {
        assert_add(arg9, arg12);
        assert_near_book<T0, T1, T2>(arg1, arg5, arg4, arg7);
        let v0 = open_move<T0>(arg0, arg1, arg4, arg2, arg3, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter());
        let v1 = &mut v0;
        let v2 = lend<T0, T1, T2>(arg1, v1, arg2, arg7, arg8);
        let v3 = &mut v0;
        let v4 = &mut v2;
        add<T0, T1, T2>(arg1, v3, arg6, arg7, v4, arg9, arg10, arg11, arg12, arg13);
        let v5 = &mut v0;
        give_back<T0>(arg1, v5, v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, arg3, v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg7)));
    }

    public fun assert_abandonable(arg0: u128, arg1: u64, arg2: u64, arg3: &vector<u64>, arg4: &vector<u64>) {
        assert!(arg0 == 0, 211);
        assert!(arg1 == 0 && arg2 == 0, 210);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg3)) {
            if (*0x1::vector::borrow<u64>(arg3, v1) > 0) {
                assert!(0x1::vector::contains<u64>(arg4, &v1), 208);
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 209);
    }

    fun assert_add(arg0: u64, arg1: u128) {
        assert!(arg0 > 0, 200);
        assert!(arg1 > 0, 201);
    }

    fun assert_floor(arg0: u64, arg1: u64) {
        assert!(arg0 > 0 || arg1 > 0, 207);
    }

    fun assert_near_book<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg2: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::assert_pool_price_near_book<T0, T1, T2>(arg0, arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg3));
    }

    public fun assert_pool_healthy(arg0: bool, arg1: bool) {
        assert!(arg0 && !arg1, 205);
    }

    fun assert_unwind_version(arg0: &PositionUnwind) {
        assert!(arg0.adapter_version == 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), 213);
    }

    public fun begin_unwind_position<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : PositionUnwind {
        let v0 = pocket_position<T0, T1, T2>(arg0, arg3);
        assert_pool_healthy(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_remove_liquidity<T1, T2>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T1, T2>(arg3, v0));
        let (v1, v2) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::begin_unwind_object<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        let (v7, v8) = if (v6 > 0) {
            let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T2>(arg2, arg3, &mut v4, v6, arg4);
            let v11 = v10;
            let v12 = v9;
            let v13 = RemoveLiquidityEvent{
                pool_id         : v5,
                position_id     : v0,
                liquidity_delta : v6,
                amount_a        : 0x2::balance::value<T1>(&v12),
                amount_b        : 0x2::balance::value<T2>(&v11),
            };
            0x2::event::emit<RemoveLiquidityEvent>(v13);
            (v12, v11)
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T2>())
        };
        let v14 = v8;
        let v15 = v7;
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_collect_fee<T1, T2>(arg3)) {
            let (v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T2>(arg2, arg3, &v4, true);
            let v18 = v17;
            let v19 = v16;
            if (0x2::balance::value<T1>(&v19) > 0 || 0x2::balance::value<T2>(&v18) > 0) {
                let v20 = 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>>(arg0);
                let v21 = CollectFeeEvent{
                    pool_id     : v5,
                    position_id : v0,
                    recipient   : 0x2::object::id_to_address(&v20),
                    sender      : 0x2::tx_context::sender(arg5),
                    fee_a       : 0x2::balance::value<T1>(&v19),
                    fee_b       : 0x2::balance::value<T2>(&v18),
                };
                0x2::event::emit<CollectFeeEvent>(v21);
            };
            0x2::balance::join<T1>(&mut v15, v19);
            0x2::balance::join<T2>(&mut v14, v18);
        };
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::add_unwind_proceeds<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, &mut v3, 1, 0, v15);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::add_unwind_proceeds<T0, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, &mut v3, 1, 0, v14);
        PositionUnwind{
            adapter_version : 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(),
            pool_id         : v5,
            nft             : v4,
            ticket          : v3,
            waived          : vector[],
        }
    }

    public fun clear_pause_sighting<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::object::ID) {
        assert_pool_healthy(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_remove_liquidity<T1, T2>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T1, T2>(arg2, arg3));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::clear_unreadable_sighting<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_object(0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2), arg3));
    }

    fun collect<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T2>(arg2, arg3, arg4, arg5);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T1>(&v3) > 0 || 0x2::balance::value<T2>(&v2) > 0) {
            let v4 = 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>>(arg0);
            let v5 = CollectFeeEvent{
                pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3),
                position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4),
                recipient   : 0x2::object::id_to_address(&v4),
                sender      : 0x2::tx_context::sender(arg6),
                fee_a       : 0x2::balance::value<T1>(&v3),
                fee_b       : 0x2::balance::value<T2>(&v2),
            };
            0x2::event::emit<CollectFeeEvent>(v5);
        };
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, v3);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, v2);
    }

    public fun collect_unwind_reward<T0, T1, T2, T3>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut PositionUnwind, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_unwind_version(arg5);
        assert!(arg5.pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3), 206);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T2, T3>(arg2, arg3, &arg5.nft, arg4, true, arg6);
        assert!(0x2::balance::value<T3>(&v0) > 0, 200);
        let v1 = 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>>(arg0);
        let v2 = CollectRewardEvent{
            pool_id       : arg5.pool_id,
            position_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg5.nft),
            recipient     : 0x2::object::id_to_address(&v1),
            sender        : 0x2::tx_context::sender(arg7),
            reward_type   : 0x1::type_name::with_defining_ids<T3>(),
            reward_amount : 0x2::balance::value<T3>(&v0),
        };
        0x2::event::emit<CollectRewardEvent>(v2);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::add_unwind_proceeds<T0, T3, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, &mut arg5.ticket, 1, 0, v0);
    }

    fun end_position_unwind<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: PositionUnwind) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, vector<u64>) {
        assert_unwind_version(&arg2);
        let PositionUnwind {
            adapter_version : _,
            pool_id         : v1,
            nft             : v2,
            ticket          : v3,
            waived          : v4,
        } = arg2;
        assert!(v1 == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), 206);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::end_unwind<T0>(arg0, v3);
        (v2, v4)
    }

    public fun evidence_reason(arg0: bool, arg1: bool) : u8 {
        if (arg0) {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reason_market_paused()
        } else {
            assert!(arg1, 204);
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reason_position_frozen()
        }
    }

    public fun finish_unwind_position<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: PositionUnwind) {
        let (v0, _) = end_position_unwind<T0, T1, T2>(arg0, arg2, arg3);
        let v2 = v0;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T2>(arg1, arg2, v2);
        let v3 = ClosePositionEvent{
            pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v2),
        };
        0x2::event::emit<ClosePositionEvent>(v3);
    }

    fun give_back<T0>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_object<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2));
    }

    fun lend<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::lend_object<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_object(0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3), arg4))
    }

    public fun observe_unwind_reward<T0, T1, T2, T3>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock) {
        let v0 = pocket_position<T0, T1, T2>(arg0, arg3);
        let v1 = 0x1::option::destroy_some<u64>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T3>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T1, T2>(arg3)));
        let v2 = !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_collect_reward<T1, T2>(arg3) || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::balance_of<T3>(arg4) < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_reward<T1, T2, T3>(arg2, arg3, v0, arg5);
        let v3 = 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version();
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::observe_pocket<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), v3, arg0, arg1, v1 + 4294967296, !v2, arg5);
        let v4 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_marked_since<T0>(arg0, v1 + 4294967296);
        if (v2 || 0x2::clock::timestamp_ms(arg5) >= *0x1::option::borrow<u64>(&v4) + 86400000) {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::observe_pocket<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), v3, arg0, arg1, v1, v2, arg5);
        };
        let v5 = ObserveRewardEvent{
            pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3),
            pocket_id       : 0x2::object::id<0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>>(arg0),
            position_id     : v0,
            reward_type     : 0x1::type_name::with_defining_ids<T3>(),
            unpayable_since : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_marked_since<T0>(arg0, v1),
            payable_since   : v4,
        };
        0x2::event::emit<ObserveRewardEvent>(v5);
    }

    fun open_move<T0>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg3: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg4: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg5: u8) : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::open_ticket<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, arg2, arg3, arg4, arg5, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_lp())
    }

    fun pocket_position<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) : 0x2::object::ID {
        let v0 = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::pocket_key<T0>(arg0);
        assert!(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_pool_id(&v0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1)), 206);
        0x1::option::destroy_some<0x2::object::ID>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::position_key_position_id(&v0))
    }

    public fun position_info(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : (u128, u32, u32) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg0);
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1))
    }

    public fun position_liquidity(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg0)
    }

    public fun reattach_position<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_pool_healthy(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_remove_liquidity<T1, T2>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T1, T2>(arg3, pocket_position<T0, T1, T2>(arg1, arg3)));
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reattach_pocket_clmm<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, arg2, arg4, arg5, arg6);
    }

    fun remove<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T2>(arg2, arg3, arg4, arg5, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T1>(&v3);
        let v5 = 0x2::balance::value<T2>(&v2);
        assert!(v4 >= arg6, 202);
        assert!(v5 >= arg7, 202);
        let v6 = RemoveLiquidityEvent{
            pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3),
            position_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4),
            liquidity_delta : arg5,
            amount_a        : v4,
            amount_b        : v5,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v6);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, v3);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, v2);
        (v4, v5)
    }

    fun take_some<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg2: u64) : 0x2::balance::Balance<T1> {
        if (arg2 == 0) {
            0x2::balance::zero<T1>()
        } else {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, arg2)
        }
    }

    public fun waive_unwind_reward<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg2: &mut PositionUnwind) {
        assert_unwind_version(arg2);
        assert!(arg2.pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0), 206);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_reward<T0, T1, T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2.nft));
        assert!(v0 > 0 && (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_collect_reward<T0, T1>(arg0) || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::balance_of<T2>(arg1) < v0), 208);
        0x1::vector::push_back<u64>(&mut arg2.waived, 0x1::option::destroy_some<u64>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg0))));
    }

    // decompiled from Move bytecode v7
}

