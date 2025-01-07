module 0xbc145c06e4a0de97596e4e09afd84155d607e4f61d3741425c2ae6a2f7c1c04d::abra_not_test_token {
    struct ABRA_NOT_TEST_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABRA_NOT_TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABRA_NOT_TEST_TOKEN>(arg0, 9, b"ABRA_NOT_TEST_TOKEN", b"ABRA TEST TOKEN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ABRA_NOT_TEST_TOKEN>(&mut v2, 9999999999000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABRA_NOT_TEST_TOKEN>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABRA_NOT_TEST_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

