module 0x1f1937b4ea0c0d0ff5c5b28aab589fdef0211b751876155b1fedc86c7c89de51::tiktok {
    struct TIKTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKTOK>(arg0, 6, b"TIKTOK", b"Tik Tok Tokook", b"Is Elon buying Tik Tok Tokook!?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1394_715312fb2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKTOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIKTOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

