module 0xe533c78d2d8d2e963d4abf3b0f90a136ba944e68b800ae3f2171a3fd3fb7a430::losers {
    struct LOSERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSERS>(arg0, 6, b"LOSERS", b"The Chicago Bears Always Lose", b"they will never win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_920c3e0709.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOSERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

