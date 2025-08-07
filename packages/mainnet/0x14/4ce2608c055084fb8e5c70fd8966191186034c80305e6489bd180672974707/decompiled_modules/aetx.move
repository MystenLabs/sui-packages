module 0x144ce2608c055084fb8e5c70fd8966191186034c80305e6489bd180672974707::aetx {
    struct AETX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AETX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AETX>(arg0, 6, b"AETX", b"AetherX", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AETX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AETX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

