module 0x2fc78e458dd58f25bc9f6eda15b2500ab79f52abfab79307e8dfe355e61f2bd0::suime {
    struct SUIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIME>(arg0, 6, b"SUIME", b"SUIME", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

