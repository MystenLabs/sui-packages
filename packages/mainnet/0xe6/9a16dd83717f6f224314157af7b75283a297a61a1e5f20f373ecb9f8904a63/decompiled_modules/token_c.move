module 0xe69a16dd83717f6f224314157af7b75283a297a61a1e5f20f373ecb9f8904a63::token_c {
    struct TOKEN_C has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_C>(arg0, 9, b"TKNC", b"TOKEN_C", b"Test token C", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_C>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_C>>(v1);
    }

    // decompiled from Move bytecode v6
}

