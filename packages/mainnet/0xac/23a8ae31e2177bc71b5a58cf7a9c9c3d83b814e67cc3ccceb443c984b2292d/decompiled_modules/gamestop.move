module 0xac23a8ae31e2177bc71b5a58cf7a9c9c3d83b814e67cc3ccceb443c984b2292d::gamestop {
    struct GAMESTOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMESTOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMESTOP>(arg0, 6, b"Gamestop", b"GameStop SUI", b"the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gamestop_568017f2c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMESTOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAMESTOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

