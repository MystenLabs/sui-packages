module 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::super_coin {
    struct CoinStore has key {
        id: 0x2::object::UID,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
        gem_treasury: 0x2::coin::TreasuryCap<SUPER_COIN>,
    }

    struct SUPER_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPER_COIN>, arg1: 0x2::coin::Coin<SUPER_COIN>) {
        0x2::coin::burn<SUPER_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUPER_COIN>>(0x2::coin::mint<SUPER_COIN>(arg0, arg1, arg3), arg2);
    }

    public fun buy_action() : 0x1::string::String {
        0x1::string::utf8(b"buy")
    }

    public fun buy_gems(arg0: &mut CoinStore, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<SUPER_COIN>, 0x2::token::ActionRequest<SUPER_COIN>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = if (v0 == 10000000000) {
            100
        } else if (v0 == 100000000000) {
            5000
        } else {
            assert!(v0 == 1000000000000, 0);
            100000
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.profits, arg1);
        (0x2::token::mint<SUPER_COIN>(&mut arg0.gem_treasury, v1, arg2), 0x2::token::new_request<SUPER_COIN>(buy_action(), v1, 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<SUPER_COIN>>(), arg2))
    }

    fun init(arg0: SUPER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER_COIN>(arg0, 0, b"SuperCoin", b"Super Coin", b"User coin in the playgrpund", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<SUPER_COIN>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<SUPER_COIN>(&mut v6, &v5, buy_action(), arg1);
        0x2::token::allow<SUPER_COIN>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPER_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUPER_COIN>>(v2);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<SUPER_COIN>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<SUPER_COIN>(v6);
    }

    // decompiled from Move bytecode v6
}

