module 0xfb034815efb940577b250785a9a0a49bfa6145c5d07c1992cf764e3f9c055b0::memegame {
    struct MEMEGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEGAME>(arg0, 6, b"MEMEGAME", b"MEME GAME", x"4d656d652067616d653b20697320616e206172746966696369616c20696e74656c6c6967656e636520737569206d656d652067656e65726174696f6e2067616d652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953712523.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEGAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEGAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

