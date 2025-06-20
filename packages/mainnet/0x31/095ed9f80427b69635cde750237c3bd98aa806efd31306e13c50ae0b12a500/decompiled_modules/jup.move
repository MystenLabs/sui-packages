module 0x31095ed9f80427b69635cde750237c3bd98aa806efd31306e13c50ae0b12a500::jup {
    struct JUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUP>(arg0, 8, b"JUP", b"Jupiter", b"ZO Virtual Coin for Jupiter", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JUP>>(v0);
    }

    // decompiled from Move bytecode v6
}

