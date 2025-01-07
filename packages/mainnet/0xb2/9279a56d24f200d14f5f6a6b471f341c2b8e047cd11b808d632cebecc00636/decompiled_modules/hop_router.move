module 0xb29279a56d24f200d14f5f6a6b471f341c2b8e047cd11b808d632cebecc00636::hop_router {
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

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg2: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 * arg0.buy_fee / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg4 + v0, 2);
        let (v1, v2) = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy_returns<T0>(arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg4, arg6), 18446744073709551615, arg5, 0x2::tx_context::sender(arg6), arg6);
        let v3 = v2;
        0xb29279a56d24f200d14f5f6a6b471f341c2b8e047cd11b808d632cebecc00636::utils::send_coin<T0>(v3, 0x2::tx_context::sender(arg6));
        0xb29279a56d24f200d14f5f6a6b471f341c2b8e047cd11b808d632cebecc00636::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg6));
        0xb29279a56d24f200d14f5f6a6b471f341c2b8e047cd11b808d632cebecc00636::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg6), arg0.admin);
        0xb29279a56d24f200d14f5f6a6b471f341c2b8e047cd11b808d632cebecc00636::utils::send_coin<0x2::sui::SUI>(arg3, 0x2::tx_context::sender(arg6));
        let v4 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : arg4 - v0,
            amount_out : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<BuyEvent<T0>>(v4);
        let v5 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v5);
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

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg2: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) >= arg4, 2);
        let v0 = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T0>(arg1, arg2, 0x2::coin::split<T0>(&mut arg3, arg4, arg6), arg5, arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg5, 1);
        let v2 = v1 * arg0.sell_fee / 10000;
        0xb29279a56d24f200d14f5f6a6b471f341c2b8e047cd11b808d632cebecc00636::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg6));
        0xb29279a56d24f200d14f5f6a6b471f341c2b8e047cd11b808d632cebecc00636::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6));
        0xb29279a56d24f200d14f5f6a6b471f341c2b8e047cd11b808d632cebecc00636::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg6), arg0.admin);
        let v3 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : arg4,
            amount_out : v1 - v2,
        };
        0x2::event::emit<SellEvent<T0>>(v3);
        let v4 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v2,
        };
        0x2::event::emit<FeeCollectedEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

