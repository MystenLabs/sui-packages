module 0x7ed4017ee8e94e6c481933e2e4447921cf9b8ac33dedfc9705b275628dd48eb4::pendu {
    struct PENDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENDU>(arg0, 6, b"PENDU", b"Peng Duck", b"If SOL has PENGU, then SUI will have PENDU , the one that inherits the meme spirit, but with its own twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicy6hycslu55v4t6aeeambzebeekbgrnw2tzhuzggc2ziygqnzube")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENDU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

