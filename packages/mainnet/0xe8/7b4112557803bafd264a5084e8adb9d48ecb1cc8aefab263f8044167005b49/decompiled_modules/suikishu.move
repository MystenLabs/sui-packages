module 0xe87b4112557803bafd264a5084e8adb9d48ecb1cc8aefab263f8044167005b49::suikishu {
    struct SUIKISHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKISHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKISHU>(arg0, 6, b"SUIKISHU", b"SUIKISHU", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKISHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKISHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

