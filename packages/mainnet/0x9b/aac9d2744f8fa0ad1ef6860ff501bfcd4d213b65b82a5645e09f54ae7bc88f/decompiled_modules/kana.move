module 0x9baac9d2744f8fa0ad1ef6860ff501bfcd4d213b65b82a5645e09f54ae7bc88f::kana {
    struct KANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANA>(arg0, 6, b"KANA", b"Kana", b"The most advanced AI agent to manage asset security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1308_0ad7abc807.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

