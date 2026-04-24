module 0x7df4fd22d2d11d9cb19b487bbf3ff75f67a9e4dafe98a6d97dd69f9eb5bfe7b3::grillz {
    struct GRILLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRILLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRILLZ>(arg0, 6, b"GRILLZ", b"GRILLZ", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRILLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRILLZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

