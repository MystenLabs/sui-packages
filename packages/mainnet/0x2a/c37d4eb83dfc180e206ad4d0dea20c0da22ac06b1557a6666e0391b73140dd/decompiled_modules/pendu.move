module 0x2ac37d4eb83dfc180e206ad4d0dea20c0da22ac06b1557a6666e0391b73140dd::pendu {
    struct PENDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENDU>(arg0, 6, b"PENDU", b"PEN DUCK", b"If SOL has PENGU, then SUI will have PENDU , the one that inherits the meme spirit, but with its own twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihmnjltenkst23bgwgeoog6hoetvc2v5t7yiynl5x2oypyor2udyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENDU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

