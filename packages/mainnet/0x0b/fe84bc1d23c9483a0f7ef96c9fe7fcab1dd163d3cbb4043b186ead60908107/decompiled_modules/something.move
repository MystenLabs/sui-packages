module 0xbfe84bc1d23c9483a0f7ef96c9fe7fcab1dd163d3cbb4043b186ead60908107::something {
    struct SOMETHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMETHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMETHING>(arg0, 6, b"Something", b"something", b"A Token with Something behind it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3g_DJWZ_1_X_400x400_f29f9e71d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMETHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOMETHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

