module 0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    struct FaucetTreasuryEvent has copy, drop {
        treasury_cap_id: 0x2::object::ID,
    }

    public entry fun faucet(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_COIN>>(0x2::coin::mint<TEST_COIN>(arg0, 10000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_COIN>(arg0, 9, b"TEST", b"Test Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_COIN>>(0x2::coin::mint<TEST_COIN>(&mut v2, 10000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = FaucetTreasuryEvent{treasury_cap_id: 0x2::object::id<0x2::coin::TreasuryCap<TEST_COIN>>(&v2)};
        0x2::event::emit<FaucetTreasuryEvent>(v3);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TEST_COIN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

