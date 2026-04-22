module 0xea12d0e905d694e04a06fe0925508e51a10b2a4fc46772f6c6f54c2b83ce60d1::fuckbyme {
    struct FUCKBYME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKBYME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKBYME>(arg0, 6, b"FUCKBYME", b"FUCKBYME", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKBYME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKBYME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

