module 0xcf17b1985a21c32526b53ccef965e2bf33c2e180f98c2af34cc6baff7acaf8a0::coffee {
    struct COFFEE has drop {
        dummy_field: bool,
    }

    struct CoffeeShop has key {
        id: 0x2::object::UID,
        coffee_points: 0x2::coin::TreasuryCap<COFFEE>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CoffeePurchased has copy, drop, store {
        dummy_field: bool,
    }

    public fun transfer(arg0: &mut CoffeeShop, arg1: 0x2::token::Token<COFFEE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::value<COFFEE>(&arg1) > 1, 1);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<COFFEE>(&mut arg0.coffee_points, 0x2::token::transfer<COFFEE>(arg1, arg2, arg3), arg3);
        0x2::token::burn<COFFEE>(&mut arg0.coffee_points, 0x2::token::split<COFFEE>(&mut arg1, 1, arg3));
    }

    public fun buy_coffee(arg0: &mut CoffeeShop, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 10000000000, 0);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<COFFEE>(&mut arg0.coffee_points, 0x2::token::transfer<COFFEE>(0x2::token::mint<COFFEE>(&mut arg0.coffee_points, 1, arg2), 0x2::tx_context::sender(arg2), arg2), arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v4 = CoffeePurchased{dummy_field: false};
        0x2::event::emit<CoffeePurchased>(v4);
    }

    public fun claim_free(arg0: &mut CoffeeShop, arg1: 0x2::token::Token<COFFEE>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::value<COFFEE>(&arg1) == 4, 0);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<COFFEE>(&mut arg0.coffee_points, 0x2::token::spend<COFFEE>(arg1, arg2), arg2);
        let v4 = CoffeePurchased{dummy_field: false};
        0x2::event::emit<CoffeePurchased>(v4);
    }

    fun init(arg0: COFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFEE>(arg0, 0, b"COFFEE", b"Coffee Point", b"Buy 4 coffees and get 1 free", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COFFEE>>(v1);
        let v2 = CoffeeShop{
            id            : 0x2::object::new(arg1),
            coffee_points : v0,
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CoffeeShop>(v2);
    }

    // decompiled from Move bytecode v6
}

