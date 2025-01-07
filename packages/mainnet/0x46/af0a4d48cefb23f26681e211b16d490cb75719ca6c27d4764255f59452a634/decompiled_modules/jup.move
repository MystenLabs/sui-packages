module 0x46af0a4d48cefb23f26681e211b16d490cb75719ca6c27d4764255f59452a634::jup {
    struct JUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUP>(arg0, 6, b"JUP", b"Jupiter", b"Jupiter on turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949429036.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

