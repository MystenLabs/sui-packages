module 0xfa5fe7433cab33037ed382792488cdbfad236c60a691f2531501cf4d61614707::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    struct FixedSupply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<TEST>,
    }

    struct TokenPool has key {
        id: 0x2::object::UID,
        market_id: vector<u8>,
        token_balance: 0x2::balance::Balance<TEST>,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"test", b"tes wiz", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<TEST>(&mut v2, 1000000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::split<TEST>(&mut v3, 1, arg1), 0x2::tx_context::sender(arg1));
        let v4 = FixedSupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<TEST>(v2),
        };
        let v5 = TokenPool{
            id            : 0x2::object::new(arg1),
            market_id     : b"unified-token-test-mqm9l81f",
            token_balance : 0x2::coin::into_balance<TEST>(v3),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<FixedSupply>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TokenPool>(v5);
    }

    // decompiled from Move bytecode v7
}

