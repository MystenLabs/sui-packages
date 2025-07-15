module 0x1216ce0680e7492085149e40b551031275c02d99a8c85fce02ba04fc88b7b769::usduc {
    struct USDUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDUC>(arg0, 6, b"USDUC", b"Unstable Coin", b"u can't get rich by holding stablecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiegxfnqya2blgc5cpeavx7pkqwmxm4tpevmzizmmc3pjzdescutxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDUC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

