module 0x2248932d0befecabec33abd3858271a41b89cf99d5f90d88eae74f55c071d117::suimpson {
    struct SUIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPSON>(arg0, 6, b"SUIMPSON", b"BART SUIMPSON", b"Bart simpson character on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3554_eacc1f10ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

