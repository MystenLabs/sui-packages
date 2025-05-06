module 0x1816ba9e17211ede60dccf3307c56d558091de3dbc93df75cca6f9b1f27edecb::skibidi {
    struct SKIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDI>(arg0, 6, b"SKIBIDI", b"Skibidi Toilet", b"No tg, no web, all MEME.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7142_1fddbf3f85.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

