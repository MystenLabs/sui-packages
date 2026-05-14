module 0x3f8a4b55b7a79a060b871718d588e7c7572ba79d78926cc6511610a6b1aaefce::tsetse {
    struct TSETSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSETSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSETSE>(arg0, 6, b"TSETSE", b"TSETSE", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSETSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSETSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

