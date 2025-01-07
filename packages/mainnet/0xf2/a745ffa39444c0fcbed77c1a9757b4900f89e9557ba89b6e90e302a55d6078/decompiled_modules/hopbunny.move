module 0xf2a745ffa39444c0fcbed77c1a9757b4900f89e9557ba89b6e90e302a55d6078::hopbunny {
    struct HOPBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPBUNNY>(arg0, 6, b"Hopbunny", b"Hop bunny Sui", b"Dex is updated Now Moon Easy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9314_9802d53c00.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

