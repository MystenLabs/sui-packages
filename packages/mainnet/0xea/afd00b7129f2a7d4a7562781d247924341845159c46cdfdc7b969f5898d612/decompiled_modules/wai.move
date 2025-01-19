module 0xeaafd00b7129f2a7d4a7562781d247924341845159c46cdfdc7b969f5898d612::wai {
    struct WAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAI>(arg0, 6, b"WAI", b"Wolf AI", b"A decentralized, AI-powered ecosystem fostering creativity, inclusivity, and transparency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2195_8ec0f268a5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

