module 0xe1415f5050cb51b071371dcea20ef0661c587dc5af88980c6503fa9ca2aa5114::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    struct FixedSupply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<WAGMI>,
    }

    struct TokenPool has key {
        id: 0x2::object::UID,
        market_id: vector<u8>,
        token_balance: 0x2::balance::Balance<WAGMI>,
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGMI>(arg0, 9, b"WAGMI", b"Wagmi Wizard", b"the omnichain wizard coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<WAGMI>(&mut v2, 1000000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAGMI>>(0x2::coin::split<WAGMI>(&mut v3, 1, arg1), 0x2::tx_context::sender(arg1));
        let v4 = FixedSupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<WAGMI>(v2),
        };
        let v5 = TokenPool{
            id            : 0x2::object::new(arg1),
            market_id     : b"unified-token-wagmi-mqlkqglj",
            token_balance : 0x2::coin::into_balance<WAGMI>(v3),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAGMI>>(v1);
        0x2::transfer::public_transfer<FixedSupply>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TokenPool>(v5);
    }

    // decompiled from Move bytecode v7
}

