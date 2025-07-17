module 0x59f8a8e23f5c323dcef1ffea2cbc6af9b2fd15640b7d70a83ee6ca003291345c::lumo {
    struct LUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMO>(arg0, 9, b"LUMO", b"lumo", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUMO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

