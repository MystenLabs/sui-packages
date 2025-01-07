module 0x10ffaf69f0317dc8ec5bad0d1249f8ecbd5cb305e6351a53fccb06504949dcf6::iron {
    struct IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRON>(arg0, 6, b"IRON", b"IRON X3000", b"we will got x3000 from iron men sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_28_10_50_32_4d80c9343d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

