module 0x2593cf48cd5989969c6dce24e068fd4f5bd9d9b3f97dbc3c8f4a012a7a24d7c1::tia {
    struct TIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIA>(arg0, 6, b"TIA", b"Wrapped Coin for Tia", b"Sudo Wrapped Coin for Tia", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TIA>>(v0);
    }

    // decompiled from Move bytecode v6
}

