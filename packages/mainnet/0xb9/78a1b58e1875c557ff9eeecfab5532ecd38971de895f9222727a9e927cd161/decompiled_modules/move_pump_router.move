module 0xb978a1b58e1875c557ff9eeecfab5532ecd38971de895f9222727a9e927cd161::move_pump_router {
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

    public entry fun buy_exact_out<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg0, arg1, arg2, arg3, arg5, arg7);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1) - 0x2::coin::value<0x2::sui::SUI>(&v2);
        assert!(v3 <= arg4, 2);
        0xb978a1b58e1875c557ff9eeecfab5532ecd38971de895f9222727a9e927cd161::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg7));
        0xb978a1b58e1875c557ff9eeecfab5532ecd38971de895f9222727a9e927cd161::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg7));
        let v4 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : v3,
            amount_out : arg3,
        };
        0x2::event::emit<BuyEvent<T0>>(v4);
        let v5 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 3);
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg6), arg3, arg4, arg6);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        assert!(v3 >= arg3, 1);
        0xb978a1b58e1875c557ff9eeecfab5532ecd38971de895f9222727a9e927cd161::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg6));
        0xb978a1b58e1875c557ff9eeecfab5532ecd38971de895f9222727a9e927cd161::utils::send_coin<T0>(arg1, 0x2::tx_context::sender(arg6));
        0xb978a1b58e1875c557ff9eeecfab5532ecd38971de895f9222727a9e927cd161::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg6));
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

