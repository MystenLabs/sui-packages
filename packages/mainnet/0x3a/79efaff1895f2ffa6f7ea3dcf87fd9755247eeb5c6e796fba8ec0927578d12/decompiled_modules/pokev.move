module 0x3a79efaff1895f2ffa6f7ea3dcf87fd9755247eeb5c6e796fba8ec0927578d12::pokev {
    struct POKEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEV>(arg0, 6, b"PokeV", b"PokeVerse", b"Welcome to the PokeVerse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7145_3644e055bb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

