module 0xb8d8dbbdba77ac9fffb491911d277f98c88b03635398bab1e28e027ed1ca179d::ace {
    struct ACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ACE>(arg0, 6, b"ACE", b"Poker Ace Agent by SuiAI", b"Master the game with AI-powered learning .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_0d4280b5d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ACE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

