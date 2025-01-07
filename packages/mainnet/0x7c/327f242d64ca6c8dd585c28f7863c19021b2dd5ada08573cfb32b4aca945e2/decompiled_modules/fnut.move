module 0x7c327f242d64ca6c8dd585c28f7863c19021b2dd5ada08573cfb32b4aca945e2::fnut {
    struct FNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNUT>(arg0, 6, b"FNUT", b"Frog Nut Sui", b"Pnut became a Frog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FNUT_df77d3f67b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

