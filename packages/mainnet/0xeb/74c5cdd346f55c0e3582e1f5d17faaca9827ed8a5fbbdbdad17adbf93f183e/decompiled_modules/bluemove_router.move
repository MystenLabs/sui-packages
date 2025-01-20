module 0xeb74c5cdd346f55c0e3582e1f5d17faaca9827ed8a5fbbdbdad17adbf93f183e::bluemove_router {
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

    public entry fun buy_exact_in<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<0x2::sui::SUI, T0>(v0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg4), arg1, arg2, arg4);
        0xeb74c5cdd346f55c0e3582e1f5d17faaca9827ed8a5fbbdbdad17adbf93f183e::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg4));
        0xeb74c5cdd346f55c0e3582e1f5d17faaca9827ed8a5fbbdbdad17adbf93f183e::utils::send_coin<0x2::sui::SUI>(arg0, 0x2::tx_context::sender(arg4));
        let v2 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg4),
            amount_in  : v0,
            amount_out : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<BuyEvent<T0>>(v2);
        let v3 = OrderCompletedEvent{order_id: arg3};
        0x2::event::emit<OrderCompletedEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg0, 1);
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, 0x2::sui::SUI>(arg0, 0x2::coin::split<T0>(&mut arg1, arg0, arg5), arg2, arg3, arg5);
        0xeb74c5cdd346f55c0e3582e1f5d17faaca9827ed8a5fbbdbdad17adbf93f183e::utils::send_coin<T0>(arg1, 0x2::tx_context::sender(arg5));
        0xeb74c5cdd346f55c0e3582e1f5d17faaca9827ed8a5fbbdbdad17adbf93f183e::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5));
        let v1 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg5),
            amount_in  : arg0,
            amount_out : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<SellEvent<T0>>(v1);
        let v2 = OrderCompletedEvent{order_id: arg4};
        0x2::event::emit<OrderCompletedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

