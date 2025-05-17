module 0xa3f8cb152accf73f85c12e970ba51fda77b2ac635dc211eedf949c1c7de5fe02::krak {
    struct KRAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAK>(arg0, 6, b"KRAK", b"Kraken", b"Krak the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic4vpe4f6fmjljrotmcaykkiri6bzkkbiqnnmjzbov6hmiwtqcccm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

