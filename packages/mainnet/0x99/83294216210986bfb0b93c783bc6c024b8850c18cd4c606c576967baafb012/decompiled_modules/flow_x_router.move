module 0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::flow_x_router {
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

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * arg0.buy_fee / 10000;
        let v1 = arg2 - v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg2, 3);
        let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<0x2::sui::SUI, T0>(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg6), arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 >= arg3, 1);
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg6));
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<0x2::sui::SUI>(arg4, 0x2::tx_context::sender(arg6));
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg6), arg0.admin);
        let v4 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : v1,
            amount_out : v3,
        };
        0x2::event::emit<BuyEvent<T0>>(v4);
        let v5 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v5);
        let v6 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v6);
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

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg2, 3);
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, 0x2::sui::SUI>(arg1, 0x2::coin::split<T0>(&mut arg4, arg2, arg6), arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = v1 * arg0.sell_fee / 10000;
        assert!(v1 - v2 >= arg3, 1);
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg6));
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6));
        0x9983294216210986bfb0b93c783bc6c024b8850c18cd4c606c576967baafb012::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg6), arg0.admin);
        let v3 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : arg2,
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

