module 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::order {
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

    public fun amount_in<T0>(arg0: &Order<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun assert_settleable(arg0: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::Policy, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::agent(arg0), 13906835213725466625);
        assert!(0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::is_pool_allowed(arg0, arg2), 13906835218020564995);
        assert!(arg2 == arg1, 13906835239495532549);
        assert!(0x2::clock::timestamp_ms(arg4) < arg3, 13906835243790630919);
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 13906834681150439439);
        assert!(arg2 > 0, 13906834689740242957);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg5), 13906834698329784327);
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
        0x2::transfer::share_object<Order<T0>>(v2);
        v3
    }

    public fun destination<T0>(arg0: &Order<T0>) : address {
        arg0.destination
    }

    public fun expires_at_ms<T0>(arg0: &Order<T0>) : u64 {
        arg0.expires_at_ms
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
        assert!(0x2::clock::timestamp_ms(arg1) >= v6, 13906834827178934281);
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
        let (v0, v1, v2, v3, v4) = unpack<T0>(arg1);
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let (v7, v8) = 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::swap_balance_a2b<T0, T1>(v5, arg2, arg3, v6, arg4, arg5);
        let v9 = v8;
        let v10 = 0x2::balance::value<T1>(&v9);
        assert!(v10 >= v2, 13906834981797888011);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg6), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg6), v1);
        let v11 = OrderSettled{
            order_id    : v3,
            maker       : v4,
            settler     : 0x2::tx_context::sender(arg6),
            pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            amount_in   : v6,
            amount_out  : v10,
            min_out     : v2,
            destination : v1,
        };
        0x2::event::emit<OrderSettled>(v11);
    }

    public fun settle_b2a<T0, T1>(arg0: &0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::Policy, arg1: Order<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_settleable(arg0, arg1.pool_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg1.expires_at_ms, arg5, arg6);
        let (v0, v1, v2, v3, v4) = unpack<T1>(arg1);
        let v5 = v0;
        let v6 = 0x2::balance::value<T1>(&v5);
        let (v7, v8) = 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::policy::swap_balance_b2a<T0, T1>(v5, arg2, arg3, v6, arg4, arg5);
        let v9 = v8;
        let v10 = 0x2::balance::value<T0>(&v9);
        assert!(v10 >= v2, 13906835114941874187);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg6), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg6), v1);
        let v11 = OrderSettled{
            order_id    : v3,
            maker       : v4,
            settler     : 0x2::tx_context::sender(arg6),
            pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            amount_in   : v6,
            amount_out  : v10,
            min_out     : v2,
            destination : v1,
        };
        0x2::event::emit<OrderSettled>(v11);
    }

    fun unpack<T0>(arg0: Order<T0>) : (0x2::balance::Balance<T0>, address, u64, 0x2::object::ID, address) {
        let Order {
            id            : v0,
            maker         : v1,
            destination   : v2,
            funds         : v3,
            pool_id       : _,
            min_out       : v5,
            expires_at_ms : _,
        } = arg0;
        let v7 = v0;
        0x2::object::delete(v7);
        (v3, v2, v5, 0x2::object::uid_to_inner(&v7), v1)
    }

    // decompiled from Move bytecode v7
}

