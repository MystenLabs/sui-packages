module 0xbea6355e085f47efcbcb3a204d959dd21245a6dc2d7acb89092c92a78a008b99::hallbo {
    struct HALLBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLBO>(arg0, 6, b"HALLBO", b"HALLBULLOWEN", x"5765623a2068747470733a2f2f68616c6c626f2e636f0a583a2068747470733a2f2f782e636f6d2f48414c4c42554c4c4f57454e0a54473a2068747470733a2f2f742e6d652f2b78366d615773364a585f45344e6a5179", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_232020_547_7a29d3be44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

