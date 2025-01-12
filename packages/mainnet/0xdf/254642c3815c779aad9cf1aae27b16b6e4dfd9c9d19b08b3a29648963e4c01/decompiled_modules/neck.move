module 0xdf254642c3815c779aad9cf1aae27b16b6e4dfd9c9d19b08b3a29648963e4c01::neck {
    struct NECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NECK>(arg0, 6, b"NECK", b"Daddy Longneck", x"4461646479204c6f6e676e65636b206973206865726520616e6420726570726573656e74696e672074686520626c6f636b0a4865206973207465616d696e67207570207769746820576964656e65636b206f6e636520616761696e20666f722074686520746f702073706f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_03be7236f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NECK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NECK>>(v1);
    }

    // decompiled from Move bytecode v6
}

