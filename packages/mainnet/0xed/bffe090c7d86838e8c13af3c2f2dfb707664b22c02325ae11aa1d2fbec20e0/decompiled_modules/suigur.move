module 0xedbffe090c7d86838e8c13af3c2f2dfb707664b22c02325ae11aa1d2fbec20e0::suigur {
    struct SUIGUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUR>(arg0, 6, b"SUIGUR", b"SUIGGUR", x"53756967677572207468652042656e67616c757220697320726f6172696e67206173206974206761696e73206f6e20245355492024537569676775720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/compra_fa10eebe39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

