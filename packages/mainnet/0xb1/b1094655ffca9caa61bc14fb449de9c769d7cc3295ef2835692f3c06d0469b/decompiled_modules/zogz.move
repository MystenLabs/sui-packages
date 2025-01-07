module 0xb1b1094655ffca9caa61bc14fb449de9c769d7cc3295ef2835692f3c06d0469b::zogz {
    struct ZOGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOGZ>(arg0, 6, b"ZOGZ", b"ZOGZ FORG SUI", b"One of Matt Furies Best Creation. Space Zogz Forg, Fighting space pirates  in SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_01_53_12_52d2748f46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOGZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

