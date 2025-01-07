module 0x5922c6082cb13630329630b147356f5a42753dcd0fbb97f0d1945583287fa12f::mate {
    struct MATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATE>(arg0, 6, b"MATE", b"Chess Mate", b"ChessMate (MATE), the first chess-themed crypto token designed for betting on chess games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002955_a281ca30bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

