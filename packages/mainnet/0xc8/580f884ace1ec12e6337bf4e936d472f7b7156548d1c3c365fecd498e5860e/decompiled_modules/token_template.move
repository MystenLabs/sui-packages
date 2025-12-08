module 0xc8580f884ace1ec12e6337bf4e936d472f7b7156548d1c3c365fecd498e5860e::token_template {
    struct TOKEN_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_TEMPLATE>(arg0, 9, b"MX1369546", b"MixedTest1 369546", b"Token for mixed operations test 1", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_TEMPLATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

