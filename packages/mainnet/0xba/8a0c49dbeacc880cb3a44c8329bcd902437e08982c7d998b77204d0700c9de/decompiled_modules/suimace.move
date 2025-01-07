module 0xba8a0c49dbeacc880cb3a44c8329bcd902437e08982c7d998b77204d0700c9de::suimace {
    struct SUIMACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMACE>(arg0, 6, b"SUIMACE", b"Suimace", b"The New grim ace. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014791_42d7c1ed94.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

