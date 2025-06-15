module 0xbe6a7816b73ccef0362b78facdeb924219e46d0c22c823d22de73d91e18f9003::flowxv3_router {
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

    public entry fun buy_exact_in<T0>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg5, 0, arg6, arg3, arg4, arg8);
        let v1 = 0x2::coin::value<T0>(&v0);
        assert!(v1 >= arg5, 1);
        0xbe6a7816b73ccef0362b78facdeb924219e46d0c22c823d22de73d91e18f9003::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg8));
        let v2 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            amount_out : v1,
        };
        0x2::event::emit<BuyEvent<T0>>(v2);
        let v3 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg5, 0, arg6, arg3, arg4, arg8);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg5, 1);
        0xbe6a7816b73ccef0362b78facdeb924219e46d0c22c823d22de73d91e18f9003::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg8));
        let v2 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : 0x2::coin::value<T0>(&arg2),
            amount_out : v1,
        };
        0x2::event::emit<SellEvent<T0>>(v2);
        let v3 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

