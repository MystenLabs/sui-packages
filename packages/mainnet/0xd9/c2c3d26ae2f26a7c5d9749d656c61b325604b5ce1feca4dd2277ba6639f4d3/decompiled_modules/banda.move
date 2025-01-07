module 0xd9c2c3d26ae2f26a7c5d9749d656c61b325604b5ce1feca4dd2277ba6639f4d3::banda {
    struct BANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDA>(arg0, 6, b"BANDA", b"Banda The Panda", b"Banda is a panda with a dream. A dream to make it big. A dream to leave his normie life behind. He's locked in and hustling. Lockin with Banda.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_25fa717187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

