module 0x6aab3440ab6b2442d23089c3520ac8e2a61da91e2df927d1a9066f6268f6cf86::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TEST_TOKEN>(arg0, 9, b"MIEMIE", b"Miemie Token", b"Miemie token for monitoring functions", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TEST_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

