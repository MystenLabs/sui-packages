module 0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::bluefin_router {
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

    public entry fun buy_exact_in<T0, T1>(arg0: &FeeObject, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: bool, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5 * arg0.buy_fee / 10000;
        let v1 = arg5 - v0;
        if (arg9) {
            0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::utils::send_coin<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg11), arg0.admin);
        } else {
            0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::utils::send_coin<T1>(0x2::coin::split<T1>(&mut arg4, v0, arg11), arg0.admin);
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg8, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg9, true, v1, arg6, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = if (arg9) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::utils::send_balance<T0>(v5, 0x2::tx_context::sender(arg11), arg11);
        0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::utils::send_balance<T1>(v4, 0x2::tx_context::sender(arg11), arg11);
        if (arg9) {
            let v7 = BuyEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : v1,
                amount_out : v6,
            };
            0x2::event::emit<BuyEvent<T1>>(v7);
        } else {
            let v8 = BuyEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : v1,
                amount_out : v6,
            };
            0x2::event::emit<BuyEvent<T0>>(v8);
        };
        let v9 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v9);
        let v10 = OrderCompletedEvent{order_id: arg10};
        0x2::event::emit<OrderCompletedEvent>(v10);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 100,
            sell_fee : 100,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0, T1>(arg0: &FeeObject, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: bool, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg8, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg9, true, arg5, 0, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg9) {
            0x2::balance::value<T1>(&v2)
        } else {
            0x2::balance::value<T0>(&v3)
        };
        let v5 = v4 * arg0.sell_fee / 10000;
        if (arg9) {
            0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::utils::send_coin<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v5), arg11), arg0.admin);
        } else {
            0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v5), arg11), arg0.admin);
        };
        assert!(v4 - v5 >= arg6, 1);
        0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::utils::send_balance<T0>(v3, 0x2::tx_context::sender(arg11), arg11);
        0xac2ff274e7f86fd6d7ab47466d35d51f84e4eb802e8f11890f1c5597f7e7abc0::utils::send_balance<T1>(v2, 0x2::tx_context::sender(arg11), arg11);
        if (arg9) {
            let v6 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : arg5,
                amount_out : v4 - v5,
            };
            0x2::event::emit<SellEvent<T0>>(v6);
        } else {
            let v7 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : arg5,
                amount_out : v4 - v5,
            };
            0x2::event::emit<SellEvent<T1>>(v7);
        };
        let v8 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v5,
        };
        0x2::event::emit<FeeCollectedEvent>(v8);
        let v9 = OrderCompletedEvent{order_id: arg10};
        0x2::event::emit<OrderCompletedEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

