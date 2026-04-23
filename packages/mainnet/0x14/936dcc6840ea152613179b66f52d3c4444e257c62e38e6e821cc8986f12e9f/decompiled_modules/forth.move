module 0x14936dcc6840ea152613179b66f52d3c4444e257c62e38e6e821cc8986f12e9f::forth {
    struct FORTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORTH>(arg0, 6, b"FORTH", b"FORTH", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FORTH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

