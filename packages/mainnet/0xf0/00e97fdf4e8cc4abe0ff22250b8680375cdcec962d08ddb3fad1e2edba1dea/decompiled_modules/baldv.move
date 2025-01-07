module 0xf000e97fdf4e8cc4abe0ff22250b8680375cdcec962d08ddb3fad1e2edba1dea::baldv {
    struct BALDV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDV>(arg0, 6, b"BALDV", b"Bald Vegeta", b"Hair line to the moooon.. Prince of the Suiyans. Your dream hairstyle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1066_c198364d5b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALDV>>(v1);
    }

    // decompiled from Move bytecode v6
}

