module 0x766ac400986c23549b2ee673a37e518dee04bb3a22f9b953496b5e31c5036772::promo {
    struct Rewards has key {
        id: 0x2::object::UID,
        is_ready: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TypedKey<phantom T0: store + key> has copy, drop, store {
        dummy_field: bool,
    }

    entry fun buy_nft_into_kiosk<T0: store + key, T1>(arg0: &mut Rewards, arg1: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::tx_context::TxContext) {
        rebate<T0>(arg0, arg5);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::fixed_price::buy_nft_into_kiosk<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    entry fun buy_whitelisted_nft_into_kiosk<T0: store + key, T1>(arg0: &mut Rewards, arg1: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::market_whitelist::Certificate, arg6: &mut 0x2::tx_context::TxContext) {
        rebate<T0>(arg0, arg6);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::fixed_price::buy_whitelisted_nft_into_kiosk<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Rewards{
            id       : 0x2::object::new(arg0),
            is_ready : false,
            balance  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Rewards>(v0);
    }

    fun rebate<T0: store + key>(arg0: &mut Rewards, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.is_ready) {
            let v1 = TypedKey<T0>{dummy_field: false};
            0x2::dynamic_field::exists_<TypedKey<T0>>(&arg0.id, v1)
        } else {
            false
        };
        if (v0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= 5000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 5000000000, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    entry fun setup<T0: store + key>(arg0: &mut Rewards, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 12500000000000, 0);
        assert!(0x2::tx_context::sender(arg2) == @0xcb6a5c15cba57e5033cf3c2b8dc56eafa8a0564a1810f1f2f1341a663b575d54, 2);
        assert!(!arg0.is_ready, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        arg0.is_ready = true;
        let v0 = TypedKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<TypedKey<T0>, bool>(&mut arg0.id, v0, true);
    }

    // decompiled from Move bytecode v6
}

