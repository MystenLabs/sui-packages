module 0x19ea7c7f6a3738524624aefaffde0b401c595abcc291ad3a1c6a5ffa6daa9d13::suibat {
    struct SUIBAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAT>(arg0, 6, b"SUIBAT", b"BatWall On Sui", b"$SUIBAT: Walrus Knight!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiboflh5nfpzz5acv7ijdgzg3ibbln535qh6eufqhtvh6zutq2j3qy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

