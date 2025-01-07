module 0xafb5c7dd3ec6c8106d141f5031bc0d8ca4bd23ad0f947ca14f31465d74fe9580::aaakitten {
    struct AAAKITTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAKITTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAKITTEN>(arg0, 6, b"aaaKitten", b"aaaKitten CTO", b"Can't stop, won't stop (raving about Sui).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6729_3f39692e96_896045a57f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAKITTEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAKITTEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

