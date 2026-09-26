module 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::order {
    struct FeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SettledKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Order<phantom T0> has store, key {
        id: 0x2::object::UID,
        maker: address,
        destination: address,
        funds: 0x2::balance::Balance<T0>,
        pool_id: 0x2::object::ID,
        min_out: u64,
        expires_at_ms: u64,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        maker: address,
        destination: address,
        pool_id: 0x2::object::ID,
        amount_in: u64,
        min_out: u64,
        expires_at_ms: u64,
    }

    struct OrderSettled has copy, drop {
        order_id: 0x2::object::ID,
        maker: address,
        settler: address,
        pool_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        min_out: u64,
        destination: address,
    }

    struct OrderRefunded has copy, drop {
        order_id: 0x2::object::ID,
        maker: address,
        amount: u64,
        refunded_by: address,
    }

    struct OrderBurned has copy, drop {
        order_id: 0x2::object::ID,
        maker: address,
        burned_by: address,
    }

    public fun amount_in<T0>(arg0: &Order<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun assert_pays_out(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg1 < arg0, 13906836115670171673);
        assert!(arg0 - arg1 >= arg2, 13906836132849254413);
    }

    fun assert_settleable(arg0: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::Policy, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::agent(arg0), 13906835922395201539);
        assert!(0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::is_pool_allowed(arg0, arg2), 13906835926690299909);
        assert!(arg2 == arg1, 13906835948165267463);
        assert!(0x2::clock::timestamp_ms(arg4) < arg3, 13906835952460365833);
    }

    fun build<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Order<T0>, 0x2::object::ID) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 13906835213726515217);
        assert!(arg2 > 0, 13906835222316318735);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg5), 13906835230905860105);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = Order<T0>{
            id            : 0x2::object::new(arg6),
            maker         : v1,
            destination   : arg4,
            funds         : 0x2::coin::into_balance<T0>(arg0),
            pool_id       : arg1,
            min_out       : arg2,
            expires_at_ms : arg3,
        };
        let v3 = 0x2::object::id<Order<T0>>(&v2);
        let v4 = OrderCreated{
            order_id      : v3,
            maker         : v1,
            destination   : arg4,
            pool_id       : arg1,
            amount_in     : v0,
            min_out       : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<OrderCreated>(v4);
        (v2, v3)
    }

    public fun burn<T0>(arg0: Order<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Order {
            id            : v0,
            maker         : v1,
            destination   : _,
            funds         : v3,
            pool_id       : _,
            min_out       : _,
            expires_at_ms : _,
        } = arg0;
        let v7 = v3;
        let v8 = v0;
        assert!(0x2::tx_context::sender(arg1) == v1, 13906836313238536215);
        assert!(0x2::balance::value<T0>(&v7) == 0, 13906836317533372437);
        0x2::balance::destroy_zero<T0>(v7);
        let v9 = SettledKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<SettledKey>(&v8, v9), 13906836339008208917);
        let v10 = SettledKey{dummy_field: false};
        0x2::dynamic_field::remove<SettledKey, bool>(&mut v8, v10);
        0x2::object::delete(v8);
        let v11 = OrderBurned{
            order_id  : 0x2::object::uid_to_inner(&v8),
            maker     : v1,
            burned_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<OrderBurned>(v11);
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = build<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::share_object<Order<T0>>(v0);
        v1
    }

    public fun create_with_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = build<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        let v2 = v0;
        if (arg3 > 0) {
            let v3 = FeeKey{dummy_field: false};
            0x2::dynamic_field::add<FeeKey, u64>(&mut v2.id, v3, arg3);
        };
        0x2::transfer::share_object<Order<T0>>(v2);
        v1
    }

    public fun create_with_policy<T0>(arg0: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::Policy, arg1: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::Vault, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::spend_vault::allowance<T0>(arg1, 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::cap_id(arg0)) >= 0x2::coin::value<T0>(&arg2), 13906835127826120705);
        let (v0, v1) = build<T0>(arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        let v2 = v0;
        if (arg5 > 0) {
            let v3 = FeeKey{dummy_field: false};
            0x2::dynamic_field::add<FeeKey, u64>(&mut v2.id, v3, arg5);
        };
        0x2::transfer::share_object<Order<T0>>(v2);
        v1
    }

    public fun destination<T0>(arg0: &Order<T0>) : address {
        arg0.destination
    }

    public fun expires_at_ms<T0>(arg0: &Order<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun fee<T0>(arg0: &Order<T0>) : u64 {
        fee_out<T0>(arg0)
    }

    fun fee_out<T0>(arg0: &Order<T0>) : u64 {
        let v0 = FeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FeeKey>(&arg0.id, v0)) {
            let v2 = FeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<FeeKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    fun is_settled<T0>(arg0: &Order<T0>) : bool {
        let v0 = SettledKey{dummy_field: false};
        0x2::dynamic_field::exists<SettledKey>(&arg0.id, v0)
    }

    public fun maker<T0>(arg0: &Order<T0>) : address {
        arg0.maker
    }

    public fun min_out<T0>(arg0: &Order<T0>) : u64 {
        arg0.min_out
    }

    public fun pool_id<T0>(arg0: &Order<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun refund<T0>(arg0: Order<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Order {
            id            : v0,
            maker         : v1,
            destination   : _,
            funds         : v3,
            pool_id       : _,
            min_out       : _,
            expires_at_ms : v6,
        } = arg0;
        let v7 = v3;
        let v8 = v0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v6, 13906835359755010059);
        0x2::object::delete(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), v1);
        let v9 = OrderRefunded{
            order_id    : 0x2::object::uid_to_inner(&v8),
            maker       : v1,
            amount      : 0x2::balance::value<T0>(&v7),
            refunded_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OrderRefunded>(v9);
    }

    public fun settle_a2b<T0, T1>(arg0: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::Policy, arg1: Order<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_settleable(arg0, arg1.pool_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg1.expires_at_ms, arg5, arg6);
        assert!(!is_settled<T0>(&arg1), 13906835497194487827);
        let v0 = arg1.destination;
        let v1 = arg1.min_out;
        let v2 = 0x2::balance::value<T0>(&arg1.funds);
        let (v3, v4) = 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::swap_balance_a2b<T0, T1>(0x2::balance::split<T0>(&mut arg1.funds, v2), arg2, arg3, v2, arg4, arg5);
        let v5 = v4;
        let v6 = 0x2::balance::value<T1>(&v5);
        let v7 = fee_out<T0>(&arg1);
        assert_pays_out(v6, v7, v1);
        let v8 = 0x2::tx_context::sender(arg6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v7), arg6), v8);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg6), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg6), v0);
        let v9 = SettledKey{dummy_field: false};
        0x2::dynamic_field::add<SettledKey, bool>(&mut arg1.id, v9, true);
        0x2::transfer::share_object<Order<T0>>(arg1);
        let v10 = OrderSettled{
            order_id    : 0x2::object::uid_to_inner(&arg1.id),
            maker       : arg1.maker,
            settler     : v8,
            pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            amount_in   : v2,
            amount_out  : v6,
            min_out     : v1,
            destination : v0,
        };
        0x2::event::emit<OrderSettled>(v10);
    }

    public fun settle_b2a<T0, T1>(arg0: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::Policy, arg1: Order<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_settleable(arg0, arg1.pool_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg1.expires_at_ms, arg5, arg6);
        assert!(!is_settled<T1>(&arg1), 13906835724827754515);
        let v0 = arg1.destination;
        let v1 = arg1.min_out;
        let v2 = 0x2::balance::value<T1>(&arg1.funds);
        let (v3, v4) = 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::swap_balance_b2a<T0, T1>(0x2::balance::split<T1>(&mut arg1.funds, v2), arg2, arg3, v2, arg4, arg5);
        let v5 = v4;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = fee_out<T1>(&arg1);
        assert_pays_out(v6, v7, v1);
        let v8 = 0x2::tx_context::sender(arg6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v7), arg6), v8);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg6), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg6), v0);
        let v9 = SettledKey{dummy_field: false};
        0x2::dynamic_field::add<SettledKey, bool>(&mut arg1.id, v9, true);
        0x2::transfer::share_object<Order<T1>>(arg1);
        let v10 = OrderSettled{
            order_id    : 0x2::object::uid_to_inner(&arg1.id),
            maker       : arg1.maker,
            settler     : v8,
            pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            amount_in   : v2,
            amount_out  : v6,
            min_out     : v1,
            destination : v0,
        };
        0x2::event::emit<OrderSettled>(v10);
    }

    public fun settled<T0>(arg0: &Order<T0>) : bool {
        is_settled<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

