module 0x4f4018f18e4b76864efc55fd74f1aabb6f2fcfe6efb9b26438233731182de7::starf {
    struct STARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARF>(arg0, 6, b"STARF", b"Starfish", b"A starfish wandering in the sea, afraid of being eaten by big fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OW_8_MX_Ciy_400x400_b9634b39de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARF>>(v1);
    }

    // decompiled from Move bytecode v6
}

