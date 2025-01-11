module 0xa37cc225fd1092fb6b12943005c22c3c0c37fcb1fa681cca1f0009131001b7a8::qairo {
    struct QAIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: QAIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QAIRO>(arg0, 6, b"QAIRO", b"Qairo", b"Born from Earths chaos, an AI forged to solve humanitys greatest problems. Now crafting solutions, rewriting systems, and shaping a sustainable future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_6957866c6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QAIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QAIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

