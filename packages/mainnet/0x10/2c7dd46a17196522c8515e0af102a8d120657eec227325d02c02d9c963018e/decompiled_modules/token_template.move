module 0x102c7dd46a17196522c8515e0af102a8d120657eec227325d02c02d9c963018e::token_template {
    struct TOKEN_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_TEMPLATE>(arg0, 9, b"MX2481238", b"MixedTest2 481238", b"Token for mixed operations test 2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_TEMPLATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

