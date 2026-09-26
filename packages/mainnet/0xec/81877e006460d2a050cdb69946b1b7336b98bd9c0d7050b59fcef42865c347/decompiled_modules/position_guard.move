module 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::position_guard {
    struct PositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionGuard<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin_vault_id: 0x2::object::ID,
        agent: address,
        destination: address,
        suspended: bool,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        min_tick_width: u32,
        max_tick_width: u32,
    }

    struct Rebalanced has copy, drop {
        guard_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct FeesCollected has copy, drop {
        guard_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        destination: address,
    }

    struct GuardUpdated has copy, drop {
        guard_id: 0x2::object::ID,
        agent: address,
        destination: address,
        suspended: bool,
    }

    public fun agent<T0, T1>(arg0: &PositionGuard<T0, T1>) : address {
        arg0.agent
    }

    fun assert_binding<T0, T1>(arg0: &PositionGuard<T0, T1>, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap) {
        assert!(owner_cap_vault_id_matches(arg1, arg0.admin_vault_id), 13906836944597549061);
    }

    fun assert_caller_is_agent<T0, T1>(arg0: &PositionGuard<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.agent, 13906836777093562369);
        assert!(!arg0.suspended, 13906836781388660739);
    }

    fun assert_pool<T0, T1>(arg0: &PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 13906836905942974471);
    }

    fun assert_pool_matches<T0, T1>(arg0: &PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 13906836811453693959);
    }

    fun assert_range_in_bounds<T0, T1>(arg0: &PositionGuard<T0, T1>, arg1: u32, arg2: u32) {
        assert!(arg1 < arg2, 13906836854403629067);
        let v0 = arg2 - arg1;
        assert!(v0 >= arg0.min_tick_width && v0 <= arg0.max_tick_width, 13906836871583367177);
    }

    fun borrow_position<T0, T1>(arg0: &mut PositionGuard<T0, T1>) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v0)
    }

    public fun collect_fees<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_caller_is_agent<T0, T1>(arg0, arg3);
        assert_pool_matches<T0, T1>(arg0, arg2);
        let v0 = arg0.destination;
        let v1 = 0x2::object::id<PositionGuard<T0, T1>>(arg0);
        let v2 = arg0.pool_id;
        let v3 = arg0.position_id;
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, borrow_position<T0, T1>(arg0), true);
        let v6 = v5;
        let v7 = v4;
        send<T0>(v7, v0, arg3);
        send<T1>(v6, v0, arg3);
        let v8 = FeesCollected{
            guard_id    : v1,
            pool_id     : v2,
            position_id : v3,
            amount_a    : 0x2::balance::value<T0>(&v7),
            amount_b    : 0x2::balance::value<T1>(&v6),
            destination : v0,
        };
        0x2::event::emit<FeesCollected>(v8);
    }

    fun combine<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::join<T0>(&mut arg0, arg1);
        arg0
    }

    public fun create<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg4: address, arg5: address, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(owner_cap_vault_id_matches(arg3, arg2), 13906834689739718661);
        assert!(arg6 < arg7, 13906834694035079179);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg6, arg7, arg10);
        let v1 = PositionGuard<T0, T1>{
            id             : 0x2::object::new(arg10),
            admin_vault_id : arg2,
            agent          : arg4,
            destination    : arg5,
            suspended      : false,
            pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            min_tick_width : arg8,
            max_tick_width : arg9,
        };
        let v2 = 0x2::object::id<PositionGuard<T0, T1>>(&v1);
        let v3 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v1.id, v3, v0);
        0x2::transfer::share_object<PositionGuard<T0, T1>>(v1);
        let v4 = GuardUpdated{
            guard_id    : v2,
            agent       : arg4,
            destination : arg5,
            suspended   : false,
        };
        0x2::event::emit<GuardUpdated>(v4);
        v2
    }

    public fun deposit_liquidity<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg4: u128, arg5: &0x2::clock::Clock, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_binding<T0, T1>(arg0, arg3);
        assert_pool<T0, T1>(arg0, arg2);
        let v0 = arg0.destination;
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, borrow_position<T0, T1>(arg0), arg4, arg5);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        pay_and_repay<T0, T1>(arg1, arg2, v1, arg6, arg7, v2, v3, v0, arg8);
    }

    public fun deposit_liquidity_fix<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        assert_binding<T0, T1>(arg0, arg3);
        assert_pool<T0, T1>(arg0, arg2);
        let v0 = arg0.destination;
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, borrow_position<T0, T1>(arg0), arg4, arg5, arg6);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        pay_and_repay<T0, T1>(arg1, arg2, v1, arg7, arg8, v2, v3, v0, arg9);
    }

    public fun destination<T0, T1>(arg0: &PositionGuard<T0, T1>) : address {
        arg0.destination
    }

    fun emit_updated<T0, T1>(arg0: &PositionGuard<T0, T1>) {
        let v0 = GuardUpdated{
            guard_id    : 0x2::object::id<PositionGuard<T0, T1>>(arg0),
            agent       : arg0.agent,
            destination : arg0.destination,
            suspended   : arg0.suspended,
        };
        0x2::event::emit<GuardUpdated>(v0);
    }

    public fun guard_id<T0, T1>(arg0: &PositionGuard<T0, T1>) : 0x2::object::ID {
        0x2::object::id<PositionGuard<T0, T1>>(arg0)
    }

    public fun is_suspended<T0, T1>(arg0: &PositionGuard<T0, T1>) : bool {
        arg0.suspended
    }

    fun owner_cap_vault_id_matches(arg0: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg1: 0x2::object::ID) : bool {
        0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::owner_cap_vault_id(arg0) == arg1
    }

    fun pay_and_repay<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, arg5), 0x2::balance::split<T1>(&mut arg4, arg6), arg2);
        send<T0>(arg3, arg7, arg8);
        send<T1>(arg4, arg7, arg8);
    }

    public fun pool_id<T0, T1>(arg0: &PositionGuard<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id<T0, T1>(arg0: &PositionGuard<T0, T1>) : 0x2::object::ID {
        arg0.position_id
    }

    public fun rebalance<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_caller_is_agent<T0, T1>(arg0, arg6);
        assert_pool_matches<T0, T1>(arg0, arg2);
        assert_range_in_bounds<T0, T1>(arg0, arg3, arg4);
        let v0 = PositionKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::remove<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v1);
        assert!(v2 > 0, 13906835402704814093);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v1, v2, arg5);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v1, true);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v1);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg6);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, &mut v7, v2, arg5);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v8);
        pay_and_repay<T0, T1>(arg1, arg2, v8, combine<T0>(v3, v5), combine<T1>(v4, v6), v9, v10, arg0.destination, arg6);
        let v11 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v7);
        arg0.position_id = v11;
        let v12 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v12, v7);
        let v13 = Rebalanced{
            guard_id        : 0x2::object::id<PositionGuard<T0, T1>>(arg0),
            pool_id         : arg0.pool_id,
            old_position_id : arg0.position_id,
            new_position_id : v11,
            tick_lower      : arg3,
            tick_upper      : arg4,
        };
        0x2::event::emit<Rebalanced>(v13);
    }

    public fun rebalance_with_rewards<T0, T1, T2>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: u32, arg5: u32, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_caller_is_agent<T0, T1>(arg0, arg7);
        assert_pool_matches<T0, T1>(arg0, arg2);
        assert_range_in_bounds<T0, T1>(arg0, arg4, arg5);
        let v0 = arg0.destination;
        let v1 = PositionKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v2);
        assert!(v3 > 0, 13906835733417295885);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v2, v3, arg6);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v2, true);
        send<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &v2, arg3, true, arg6), v0, arg7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v2);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg7);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, &mut v8, v3, arg6);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v9);
        pay_and_repay<T0, T1>(arg1, arg2, v9, combine<T0>(v4, v6), combine<T1>(v5, v7), v10, v11, v0, arg7);
        let v12 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v8);
        arg0.position_id = v12;
        let v13 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v13, v8);
        let v14 = Rebalanced{
            guard_id        : 0x2::object::id<PositionGuard<T0, T1>>(arg0),
            pool_id         : arg0.pool_id,
            old_position_id : arg0.position_id,
            new_position_id : v12,
            tick_lower      : arg4,
            tick_upper      : arg5,
        };
        0x2::event::emit<Rebalanced>(v14);
    }

    public fun redeem<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_binding<T0, T1>(arg0, arg3);
        assert_pool<T0, T1>(arg0, arg2);
        let v0 = arg0.destination;
        let v1 = PositionKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v2);
        if (v3 > 0) {
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v2, v3, arg4);
            send<T0>(v4, v0, arg5);
            send<T1>(v5, v0, arg5);
        };
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v2, true);
        send<T0>(v6, v0, arg5);
        send<T1>(v7, v0, arg5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v2);
    }

    public fun redeem_with_rewards<T0, T1, T2>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_binding<T0, T1>(arg0, arg3);
        assert_pool<T0, T1>(arg0, arg2);
        let v0 = arg0.destination;
        let v1 = PositionKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v2);
        if (v3 > 0) {
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v2, v3, arg5);
            send<T0>(v4, v0, arg6);
            send<T1>(v5, v0, arg6);
        };
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v2, true);
        send<T0>(v6, v0, arg6);
        send<T1>(v7, v0, arg6);
        send<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &v2, arg4, true, arg5), v0, arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v2);
    }

    fun send<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun set_agent<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: address) {
        assert_binding<T0, T1>(arg0, arg1);
        arg0.agent = arg2;
        emit_updated<T0, T1>(arg0);
    }

    public fun set_destination<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: address) {
        assert_binding<T0, T1>(arg0, arg1);
        arg0.destination = arg2;
        emit_updated<T0, T1>(arg0);
    }

    public fun set_suspended<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: bool) {
        assert_binding<T0, T1>(arg0, arg1);
        arg0.suspended = arg2;
        emit_updated<T0, T1>(arg0);
    }

    public fun set_tick_bounds<T0, T1>(arg0: &mut PositionGuard<T0, T1>, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::OwnerCap, arg2: u32, arg3: u32) {
        assert_binding<T0, T1>(arg0, arg1);
        arg0.min_tick_width = arg2;
        arg0.max_tick_width = arg3;
        emit_updated<T0, T1>(arg0);
    }

    public fun tick_bounds<T0, T1>(arg0: &PositionGuard<T0, T1>) : (u32, u32) {
        (arg0.min_tick_width, arg0.max_tick_width)
    }

    // decompiled from Move bytecode v7
}

