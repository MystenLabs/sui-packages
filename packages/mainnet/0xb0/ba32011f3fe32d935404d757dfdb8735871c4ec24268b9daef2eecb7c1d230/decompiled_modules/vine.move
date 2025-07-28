module 0xb0ba32011f3fe32d935404d757dfdb8735871c4ec24268b9daef2eecb7c1d230::vine {
    struct VINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINE>(arg0, 6, b"Vine", b"Vine Coin", b"the greenest way to grow your financial future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyjbwnxoaykxa2hnvgynkxigqgq63lpt6otarfmovznbi4v333sm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

