module 0xd0eadfa75869a5ec420e8cd150246b1a5bc1e9be41cc00ca87b2543bc4ab65d::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"MELANIA OFFICAL", b"Melania memes are digital collectibles intended to function as an expression of support for and engagement with the values embodied by the symbol MELANIA. and the associated artwork, and are not intended to be, or to be the subject of, an investment opportunity, investment contract, or security of", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_db2eef358c_aae1e0a6e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

