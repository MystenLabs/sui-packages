module 0x6d49c32ec3d8637ffe5a09fcee38922b57fb659a8053f6a43ffc2eef9aeb42f2::ondo {
    struct ONDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONDO>(arg0, 18, b"ONDO", b"Wrapped Ondo", b"ZO Finance Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONDO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ONDO>>(v0);
    }

    // decompiled from Move bytecode v6
}

