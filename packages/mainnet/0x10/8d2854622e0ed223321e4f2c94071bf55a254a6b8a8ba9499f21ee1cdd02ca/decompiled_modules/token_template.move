module 0x108d2854622e0ed223321e4f2c94071bf55a254a6b8a8ba9499f21ee1cdd02ca::token_template {
    struct TOKEN_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_TEMPLATE>(arg0, 9, b"MX2452263", b"MixedTest2 452263", b"Token for mixed operations test 2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_TEMPLATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

