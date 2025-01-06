module 0x552dc36c6ab91b7cabb5e4d16fd1c6003d8b50027bd095ff12605d831631c054::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOO>(arg0, 6, b"BOO", b"SuiBoo Ai by SuiAI", b"First Ghost Ai in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ghost_34f6fb4911.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

