module 0xcfd6c64600462067afdb4a290765d6fee53fb0272bd1ebbfb679da77b8788672::banda {
    struct BANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDA>(arg0, 6, b"BANDA", b"Banda The Panda", b"Banda is a panda with a dream. A dream to make it big. A dream to leave his normie life behind. He's locked in and hustling. Lockin with Banda.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_9a6ac2d9c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

