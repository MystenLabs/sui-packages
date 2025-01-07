module 0x4bf9c0e4249fe07f6869c76af04d642683deb0f1657687ea71858065c441b2f8::pepesuichain {
    struct PEPESUICHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUICHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUICHAIN>(arg0, 6, b"pSUI", b"Pepe Sui", b"t.me/PepeSuiChain", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPESUICHAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUICHAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

