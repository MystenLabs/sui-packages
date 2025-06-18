module 0x8972d56c7251df18a9efc112347e802e70188f1a7036b914381512df681aa357::bumpedfeest {
    struct BUMPEDFEEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMPEDFEEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMPEDFEEST>(arg0, 6, b"bumpedFeesT", b"bumpedFeesTest", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMPEDFEEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUMPEDFEEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

