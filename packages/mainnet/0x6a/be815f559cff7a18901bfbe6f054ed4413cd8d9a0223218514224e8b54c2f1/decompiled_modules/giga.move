module 0x6abe815f559cff7a18901bfbe6f054ed4413cd8d9a0223218514224e8b54c2f1::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGA>(arg0, 6, b"GIGA", b"GIGI", b"OLEZ GIGA SNOV GKKLLJHFHFXCGXVBV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_09_23_55_2ea28bdb72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

