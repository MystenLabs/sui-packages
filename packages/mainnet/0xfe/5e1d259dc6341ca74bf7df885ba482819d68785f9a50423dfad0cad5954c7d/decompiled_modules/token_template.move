module 0xfe5e1d259dc6341ca74bf7df885ba482819d68785f9a50423dfad0cad5954c7d::token_template {
    struct TOKEN_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_TEMPLATE>(arg0, 9, b"ZK690339", b"zkTest 690339", b"zkLogin integration test token 2025-10-28T01:24:50.339Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_TEMPLATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

