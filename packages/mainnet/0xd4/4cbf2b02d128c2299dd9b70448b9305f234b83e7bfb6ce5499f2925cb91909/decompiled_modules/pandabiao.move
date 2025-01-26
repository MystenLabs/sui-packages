module 0xd44cbf2b02d128c2299dd9b70448b9305f234b83e7bfb6ce5499f2925cb91909::pandabiao {
    struct PANDABIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDABIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDABIAO>(arg0, 6, b"PANDABIAO", b"PANDABIAO ON SUI", b"THE BEST CALL CHANNEL ON SPACE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_4800bbcebf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDABIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDABIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

