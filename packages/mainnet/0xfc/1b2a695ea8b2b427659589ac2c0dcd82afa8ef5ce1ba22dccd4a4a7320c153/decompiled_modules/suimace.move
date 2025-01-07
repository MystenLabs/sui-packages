module 0xfc1b2a695ea8b2b427659589ac2c0dcd82afa8ef5ce1ba22dccd4a4a7320c153::suimace {
    struct SUIMACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMACE>(arg0, 6, b"SUIMACE", b"GRIMACE SUI", b"Im back, grimace on sui $SUIMACE OG MEMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3596_818061f098.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

