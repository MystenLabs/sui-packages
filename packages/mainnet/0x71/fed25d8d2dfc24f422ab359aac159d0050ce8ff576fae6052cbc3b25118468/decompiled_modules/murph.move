module 0x71fed25d8d2dfc24f422ab359aac159d0050ce8ff576fae6052cbc3b25118468::murph {
    struct MURPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURPH>(arg0, 6, b"MURPH", b"Murphy on Sui", b"MURPH - The Boys Clubs best-kept secret on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_eea5ba2b26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

