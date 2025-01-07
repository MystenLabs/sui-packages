module 0x6970482ebd912a854785dce15e3c861f34cbc59086bdd6016f9253024495d4ed::test_contracts {
    struct TEST_CONTRACTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_CONTRACTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_CONTRACTS>(arg0, 9, b"CONTRACT", b"CONTRACT", b"CONTRACT", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_CONTRACTS>>(v1);
        0x2::coin::mint_and_transfer<TEST_CONTRACTS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TEST_CONTRACTS>>(v2);
    }

    // decompiled from Move bytecode v6
}

