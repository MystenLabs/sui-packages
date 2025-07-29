module 0xa47eef9839c1118551a0977a628566e20a823dedc14c8051422150306a2c349d::iykyk {
    struct IYKYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IYKYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IYKYK>(arg0, 6, b"IYKYK", b"IYKYK on Sui", b"We're training a series of fast, efficient Gradient Boosting algorithms to make binary classification and regression analysis for trade predictions, insider wallet classification copy trading. Proof of concept Money Printer beta is live in the Telegram. Jump in to find out more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiefubl5j2hmpum2s37zhmgtyus6mhzkgqlbimlttztqnq5a4yxgs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IYKYK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IYKYK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

