module 0x440e9f85af4846ca2d6e9e11f7fa6c1bb1bafbdc50fa4c0388c15e534bb83fca::blueman {
    struct BLUEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEMAN>(arg0, 6, b"Blueman", b"Blue Man", b"A blue man.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blueman_4a13bb9fa4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

