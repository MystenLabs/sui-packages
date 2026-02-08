module 0x2829f5709eac60a6f12cc6e46760b4ad9fa5b11f716d92aca3cfeb78466dbc02::dump {
    struct DUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMP>(arg0, 6, b"DUMP", b"DeepDump", b"Its not that deep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1770579246473.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

