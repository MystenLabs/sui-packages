module 0x81073a403462f4232b8bfe91bc7721ca0158db1d6cdf6c29af35689037a6dc33::test_token {
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

