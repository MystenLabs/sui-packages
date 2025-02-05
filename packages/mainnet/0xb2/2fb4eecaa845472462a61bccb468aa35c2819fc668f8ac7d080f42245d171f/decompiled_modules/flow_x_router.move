module 0xb22fb4eecaa845472462a61bccb468aa35c2819fc668f8ac7d080f42245d171f::flow_x_router {
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

    public entry fun buy_exact_in<T0>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<0x2::sui::SUI, T0>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg4), arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        assert!(v2 >= arg1, 1);
        0xb22fb4eecaa845472462a61bccb468aa35c2819fc668f8ac7d080f42245d171f::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg4));
        0xb22fb4eecaa845472462a61bccb468aa35c2819fc668f8ac7d080f42245d171f::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg4));
        let v3 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg4),
            amount_in  : v0,
            amount_out : v2,
        };
        0x2::event::emit<BuyEvent<T0>>(v3);
        let v4 = OrderCompletedEvent{order_id: arg3};
        0x2::event::emit<OrderCompletedEvent>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) >= arg1, 2);
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, 0x2::sui::SUI>(arg0, 0x2::coin::split<T0>(&mut arg3, arg1, arg5), arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg2, 1);
        0xb22fb4eecaa845472462a61bccb468aa35c2819fc668f8ac7d080f42245d171f::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg5));
        0xb22fb4eecaa845472462a61bccb468aa35c2819fc668f8ac7d080f42245d171f::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5));
        let v2 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg5),
            amount_in  : arg1,
            amount_out : v1,
        };
        0x2::event::emit<SellEvent<T0>>(v2);
        let v3 = OrderCompletedEvent{order_id: arg4};
        0x2::event::emit<OrderCompletedEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

