module 0x998832e10802375a46724e160b4aa20ce268b4c2cf14985ab1d646f09a12addd::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUU>(arg0, 6, b"SIUUU", b"SIUUU on SUI", b"SIUUU by the Goat, now on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibnnjo5epj2aiign7oxbs7y2ymkhzeh73uxzxqliczb3y6lmhmpji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIUUU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

