module 0xc83d48850b81fa72a0873ddf046f2658ac5c19e09c1320977c3218249dbde098::as {
    struct AS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AS>(arg0, 6, b"As", b"Artificial Stupidity", b"I am not so smert. Don't esk me nottin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_4f79e3b401.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AS>>(v1);
    }

    // decompiled from Move bytecode v6
}

