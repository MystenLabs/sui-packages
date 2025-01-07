module 0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::turbos_router {
    struct FeeObject has key {
        id: 0x2::object::UID,
        buy_fee: u64,
        sell_fee: u64,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0, T1, T2>(arg0: &FeeObject, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: bool, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 * arg0.buy_fee / 10000;
        let v1 = arg4 - v0;
        if (arg10) {
            assert!(0x2::coin::value<T0>(&arg2) >= arg4, 3);
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(0x2::coin::split<T0>(&mut arg2, v0, arg12), arg0.admin);
        } else {
            assert!(0x2::coin::value<T1>(&arg3) >= arg4, 3);
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T1>(0x2::coin::split<T1>(&mut arg3, v0, arg12), arg0.admin);
        };
        if (arg10) {
            let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, arg2);
            let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v2, v1, arg5, arg6, true, 0x2::tx_context::sender(arg12), arg7, arg8, arg9, arg12);
            let v5 = v3;
            let v6 = 0x2::coin::value<T1>(&v5);
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(v4, 0x2::tx_context::sender(arg12));
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T1>(v5, 0x2::tx_context::sender(arg12));
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg12));
            assert!(v6 >= arg5, 4);
            let v7 = BuyEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg12),
                amount_in  : v1,
                amount_out : v6,
            };
            0x2::event::emit<BuyEvent<T1>>(v7);
        } else {
            let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, arg3);
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v8, v1, arg5, arg6, true, 0x2::tx_context::sender(arg12), arg7, arg8, arg9, arg12);
            let v11 = v9;
            let v12 = 0x2::coin::value<T0>(&v11);
            assert!(v12 >= arg5, 4);
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T1>(v10, 0x2::tx_context::sender(arg12));
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(v11, 0x2::tx_context::sender(arg12));
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg12));
            let v13 = BuyEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg12),
                amount_in  : v1,
                amount_out : v12,
            };
            0x2::event::emit<BuyEvent<T0>>(v13);
        };
        let v14 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v14);
        let v15 = OrderCompletedEvent{order_id: arg11};
        0x2::event::emit<OrderCompletedEvent>(v15);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 90,
            sell_fee : 90,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0, T1, T2>(arg0: &FeeObject, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: bool, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg10) {
            assert!(0x2::coin::value<T0>(&arg2) >= arg4, 3);
            let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg2);
            let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v1, arg4, arg5, arg6, true, 0x2::tx_context::sender(arg12), arg7, arg8, arg9, arg12);
            let v4 = v2;
            let v5 = 0x2::coin::value<T1>(&v4);
            assert!(v5 >= arg5, 4);
            let v6 = v5 * arg0.sell_fee / 10000;
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T1>(0x2::coin::split<T1>(&mut v4, v6, arg12), arg0.admin);
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T1>(v4, 0x2::tx_context::sender(arg12));
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(v3, 0x2::tx_context::sender(arg12));
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg12));
            let v7 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg12),
                amount_in  : arg4,
                amount_out : v5 - v6,
            };
            0x2::event::emit<SellEvent<T0>>(v7);
            v6
        } else {
            assert!(0x2::coin::value<T1>(&arg3) >= arg4, 3);
            let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, arg3);
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v8, arg4, arg5, arg6, true, 0x2::tx_context::sender(arg12), arg7, arg8, arg9, arg12);
            let v11 = v9;
            let v12 = 0x2::coin::value<T0>(&v11);
            assert!(v12 >= arg5, 4);
            let v13 = v12 * arg0.sell_fee / 10000;
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(0x2::coin::split<T0>(&mut v11, v13, arg12), arg0.admin);
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(v11, 0x2::tx_context::sender(arg12));
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T1>(v10, 0x2::tx_context::sender(arg12));
            0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg12));
            let v14 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg12),
                amount_in  : arg4,
                amount_out : v12 - v13,
            };
            0x2::event::emit<SellEvent<T1>>(v14);
            v13
        };
        let v15 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v15);
        let v16 = OrderCompletedEvent{order_id: arg11};
        0x2::event::emit<OrderCompletedEvent>(v16);
    }

    // decompiled from Move bytecode v6
}

