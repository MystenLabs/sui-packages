module 0xd5d50996422e6efe2aa7d5a3e2578608634b5a2b5dbad5472804adff0f6daabc::test_contracts {
    struct TEST_CONTRACTS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_CONTRACTS>, arg1: 0x2::coin::Coin<TEST_CONTRACTS>) {
        0x2::coin::burn<TEST_CONTRACTS>(arg0, arg1);
    }

    fun init(arg0: TEST_CONTRACTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_CONTRACTS>(arg0, 9, b"ct", b"ct", b"vtt!", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_CONTRACTS>>(v1);
        0x2::coin::mint_and_transfer<TEST_CONTRACTS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_CONTRACTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

