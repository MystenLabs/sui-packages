module 0xf3df9ead2bb0430d2cdd13b184d3e61c49fc27d5b4f89364ca5571c7e3d4d18f::suigi {
    struct SUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGI>(arg0, 6, b"SUIGI", b"Suigi Mangione", b"Dedicated to the cause of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_10_22_25_45_669ecd0b1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

