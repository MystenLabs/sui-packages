module 0x36b759702bef8ca902e237470f9c8087bf253e783aadc9c4c4af10c453df4b9e::bluefin_router {
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

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: bool, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7) {
            0x2::coin::value<T0>(&arg2)
        } else {
            0x2::coin::value<T1>(&arg3)
        };
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg7, true, v0, arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = if (arg7) {
            0x2::balance::value<T1>(&v3)
        } else {
            0x2::balance::value<T0>(&v4)
        };
        0x36b759702bef8ca902e237470f9c8087bf253e783aadc9c4c4af10c453df4b9e::utils::send_balance<T0>(v4, 0x2::tx_context::sender(arg9), arg9);
        0x36b759702bef8ca902e237470f9c8087bf253e783aadc9c4c4af10c453df4b9e::utils::send_balance<T1>(v3, 0x2::tx_context::sender(arg9), arg9);
        if (arg7) {
            let v6 = BuyEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg9),
                amount_in  : v0,
                amount_out : v5,
            };
            0x2::event::emit<BuyEvent<T1>>(v6);
        } else {
            let v7 = BuyEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg9),
                amount_in  : v0,
                amount_out : v5,
            };
            0x2::event::emit<BuyEvent<T0>>(v7);
        };
        let v8 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: bool, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg8, true, arg4, 0, arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg8) {
            0x2::balance::value<T1>(&v2)
        } else {
            0x2::balance::value<T0>(&v3)
        };
        assert!(v4 >= arg5, 1);
        0x36b759702bef8ca902e237470f9c8087bf253e783aadc9c4c4af10c453df4b9e::utils::send_balance<T0>(v3, 0x2::tx_context::sender(arg10), arg10);
        0x36b759702bef8ca902e237470f9c8087bf253e783aadc9c4c4af10c453df4b9e::utils::send_balance<T1>(v2, 0x2::tx_context::sender(arg10), arg10);
        if (arg8) {
            let v5 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : arg4,
                amount_out : v4,
            };
            0x2::event::emit<SellEvent<T0>>(v5);
        } else {
            let v6 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : arg4,
                amount_out : v4,
            };
            0x2::event::emit<SellEvent<T1>>(v6);
        };
        let v7 = OrderCompletedEvent{order_id: arg9};
        0x2::event::emit<OrderCompletedEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

