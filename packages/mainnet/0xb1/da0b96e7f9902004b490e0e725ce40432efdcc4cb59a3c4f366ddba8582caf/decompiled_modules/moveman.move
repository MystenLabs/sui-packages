module 0xb1da0b96e7f9902004b490e0e725ce40432efdcc4cb59a3c4f366ddba8582caf::moveman {
    struct MOVEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEMAN>(arg0, 6, b"MOVEMAN", b"MOVE SUIMAN", b"SUPERHERO MOVEPUMP $MOVEMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3744_ef4a83b4ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

