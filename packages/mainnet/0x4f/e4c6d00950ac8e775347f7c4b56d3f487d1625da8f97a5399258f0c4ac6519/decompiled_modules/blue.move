module 0x4fe4c6d00950ac8e775347f7c4b56d3f487d1625da8f97a5399258f0c4ac6519::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"BLUE MONOCHROME", b"Blue Monochrome is one from a dizzying array of innovations that Klein pursued in order to cultivate a new aesthetic consciousness. Undivided by drawing and seemingly untouched by the artists hand, the radiant field frees color from the confines of form. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010062_15edf429de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

