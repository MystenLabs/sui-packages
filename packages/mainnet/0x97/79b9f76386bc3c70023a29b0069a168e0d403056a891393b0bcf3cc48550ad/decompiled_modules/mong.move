module 0x9779b9f76386bc3c70023a29b0069a168e0d403056a891393b0bcf3cc48550ad::mong {
    struct MONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONG>(arg0, 6, b"MONG", b"mongose", x"546865206669727374206d6f6e676f7365206f6e207375692e0a5469636b65722069733a20244d4f4e470a2d20546f2074686520244d4f4e470a0a436f6d6d756e6974790a68747470733a2f2f782e636f6d2f4d6f6e676f6e7375690a68747470733a2f2f742e6d652f4d6f6e676f6f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6_2024_09_18_18_37_09_8de5b0bc78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

