module 0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::bluemove_router {
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

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * arg0.buy_fee / 10000;
        let v1 = arg1 - v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1, 3);
        let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<0x2::sui::SUI, T0>(v1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg6), arg3, arg4, arg6);
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg6));
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg6));
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg6), arg0.admin);
        let v3 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : v1,
            amount_out : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<BuyEvent<T0>>(v3);
        let v4 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v4);
        let v5 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v5);
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

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg1, 3);
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, 0x2::sui::SUI>(arg1, 0x2::coin::split<T0>(&mut arg2, arg1, arg6), arg3, arg4, arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = v1 * arg0.sell_fee / 10000;
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg6));
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6));
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg6), arg0.admin);
        let v3 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : arg1,
            amount_out : v1 - v2,
        };
        0x2::event::emit<SellEvent<T0>>(v3);
        let v4 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v2,
        };
        0x2::event::emit<FeeCollectedEvent>(v4);
        let v5 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

