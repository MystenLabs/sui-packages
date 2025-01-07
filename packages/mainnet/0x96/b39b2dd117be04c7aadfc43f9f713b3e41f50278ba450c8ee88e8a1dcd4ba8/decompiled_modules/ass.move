module 0x96b39b2dd117be04c7aadfc43f9f713b3e41f50278ba450c8ee88e8a1dcd4ba8::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASS>(arg0, 6, b"ASS", b"A$$", b"ROUND ASS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Round_ASS_849ec3a987.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

