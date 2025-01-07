module 0x45286db1be113bf23cb7b11e0437e45cc85d0f66085689c9dd769e70f47c9008::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"TROLL", b"Troll", b"Trollface is back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Movepump_e2a7c43716.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

