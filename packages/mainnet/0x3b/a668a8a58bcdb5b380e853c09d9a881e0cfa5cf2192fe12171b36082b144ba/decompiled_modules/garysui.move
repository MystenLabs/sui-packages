module 0x3ba668a8a58bcdb5b380e853c09d9a881e0cfa5cf2192fe12171b36082b144ba::garysui {
    struct GARYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARYSUI>(arg0, 6, b"GARYSUI", b"GARY SUI", b"The long lost child of Brett.  Join Gary on his cosmic adventure, exploring the bonds of family across space and time along the SUI Chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_03_07_41_ca897a6fed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

