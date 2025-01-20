module 0x7a84c5c11c168de0501259188761b4db65ba55277813b91c8a07afd9bb291ce0::turbospump_router {
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

    public entry fun buy_exact_in<T0>(arg0: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let (v1, v2) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg0, arg1, v0, arg2, true, arg3, arg5);
        let v3 = v2;
        0x7a84c5c11c168de0501259188761b4db65ba55277813b91c8a07afd9bb291ce0::utils::send_coin<T0>(v3, 0x2::tx_context::sender(arg5));
        0x7a84c5c11c168de0501259188761b4db65ba55277813b91c8a07afd9bb291ce0::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg5));
        let v4 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg5),
            amount_in  : v0,
            amount_out : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<BuyEvent<T0>>(v4);
        let v5 = OrderCompletedEvent{order_id: arg4};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0>(arg0: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        let (v0, v1) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg6), arg2, arg3, true, arg4, arg6);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        assert!(v3 >= arg3, 1);
        0x7a84c5c11c168de0501259188761b4db65ba55277813b91c8a07afd9bb291ce0::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg6));
        0x7a84c5c11c168de0501259188761b4db65ba55277813b91c8a07afd9bb291ce0::utils::send_coin<T0>(arg1, 0x2::tx_context::sender(arg6));
        0x7a84c5c11c168de0501259188761b4db65ba55277813b91c8a07afd9bb291ce0::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg6));
        let v4 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : arg2,
            amount_out : v3,
        };
        0x2::event::emit<SellEvent<T0>>(v4);
        let v5 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

