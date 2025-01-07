module 0xa6011e38c6003f19aa95e0bf7a028b09934be0c900f1a189e6da354d8b2129c4::pimode {
    struct PIMODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIMODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIMODE>(arg0, 6, b"PIMODE", b"Pixel MooDeng", b"@PIMODE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_17_01_28_3c3aa15663.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIMODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIMODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

