module 0xbda0a49323de0d8861c19492a85e2e2c807e170794a1ae7490b474e9eab9c016::hop_router {
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

    public entry fun buy_exact_in<T0>(arg0: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy_returns<T0>(arg0, arg1, arg2, 18446744073709551615, arg3, 0x2::tx_context::sender(arg5), arg5);
        let v2 = v1;
        0xbda0a49323de0d8861c19492a85e2e2c807e170794a1ae7490b474e9eab9c016::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg5));
        0xbda0a49323de0d8861c19492a85e2e2c807e170794a1ae7490b474e9eab9c016::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5));
        let v3 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg5),
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            amount_out : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<BuyEvent<T0>>(v3);
        let v4 = OrderCompletedEvent{order_id: arg4};
        0x2::event::emit<OrderCompletedEvent>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0>(arg0: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        let v0 = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T0>(arg0, arg1, 0x2::coin::split<T0>(&mut arg2, arg3, arg6), arg4, arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg4, 1);
        0xbda0a49323de0d8861c19492a85e2e2c807e170794a1ae7490b474e9eab9c016::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg6));
        0xbda0a49323de0d8861c19492a85e2e2c807e170794a1ae7490b474e9eab9c016::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6));
        let v2 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : arg3,
            amount_out : v1,
        };
        0x2::event::emit<SellEvent<T0>>(v2);
        let v3 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

