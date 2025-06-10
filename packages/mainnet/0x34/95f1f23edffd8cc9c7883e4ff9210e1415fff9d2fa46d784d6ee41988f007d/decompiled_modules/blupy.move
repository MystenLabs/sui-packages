module 0x3495f1f23edffd8cc9c7883e4ff9210e1415fff9d2fa46d784d6ee41988f007d::blupy {
    struct BLUPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUPY>(arg0, 6, b"BLUPY", b"Blupy Sui", b"Blupy was born  not as just another memecoin, but as a symbol of laughter, freedom, and limitless creativity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaadflmjaqu24kb75pzz2p3fwlhovpba2ighunmypsoft2aivljpa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

