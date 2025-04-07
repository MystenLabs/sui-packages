module 0x6e82913ff97fc345af566bb458f1ef7f41926ffb735bd94e4d889c0b2cc68685::cards {
    struct CARDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARDS>(arg0, 6, b"CARDS", b"SUI cards", b"The first meme card on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1235_c1e49e582b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

