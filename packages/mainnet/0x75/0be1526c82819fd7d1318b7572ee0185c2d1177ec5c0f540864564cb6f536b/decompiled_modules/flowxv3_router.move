module 0x750be1526c82819fd7d1318b7572ee0185c2d1177ec5c0f540864564cb6f536b::flowxv3_router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyEvent<phantom T0, phantom T1> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0, phantom T1> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T1, T0>(arg0, arg1, arg2, arg5, 0, arg6, arg3, arg4, arg8);
        let v1 = 0x2::coin::value<T0>(&v0);
        assert!(v1 >= arg5, 1);
        0x750be1526c82819fd7d1318b7572ee0185c2d1177ec5c0f540864564cb6f536b::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg8));
        let v2 = BuyEvent<T0, T1>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : 0x2::coin::value<T1>(&arg2),
            amount_out : v1,
        };
        0x2::event::emit<BuyEvent<T0, T1>>(v2);
        let v3 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, arg2, arg5, 0, arg6, arg3, arg4, arg8);
        let v1 = 0x2::coin::value<T1>(&v0);
        assert!(v1 >= arg5, 1);
        0x750be1526c82819fd7d1318b7572ee0185c2d1177ec5c0f540864564cb6f536b::utils::send_coin<T1>(v0, 0x2::tx_context::sender(arg8));
        let v2 = SellEvent<T0, T1>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : 0x2::coin::value<T0>(&arg2),
            amount_out : v1,
        };
        0x2::event::emit<SellEvent<T0, T1>>(v2);
        let v3 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

