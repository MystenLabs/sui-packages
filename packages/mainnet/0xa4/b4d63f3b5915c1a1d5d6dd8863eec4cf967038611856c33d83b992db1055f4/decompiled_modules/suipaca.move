module 0xa4b4d63f3b5915c1a1d5d6dd8863eec4cf967038611856c33d83b992db1055f4::suipaca {
    struct SUIPACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPACA>(arg0, 6, b"SUIPACA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPACA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPACA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

