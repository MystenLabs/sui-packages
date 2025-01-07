module 0xa544df00eed601a0d4df76ce9d015a6c081f0e204caeae0e70bd255cf9c02e39::catalor {
    struct CATALOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATALOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATALOR>(arg0, 6, b"Catalor", b"CATALORIAN", b"The self-defence space cat, CATALORIAN! - Inspired by Elon Musk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bx4r7q39_400x400_489f7c4c2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATALOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATALOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

