module 0xdaf31d1facd4ea9e6c2daee489a5f9ba88bca53e5ae9ac5f82b257deacb72921::smen {
    struct SMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEN>(arg0, 6, b"SMEN", b"Suimen", x"57686f2072756e20776f6d656e3f202e2e2e204d656e212024534d454e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiman_2a436fbc27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

