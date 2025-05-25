module 0x88faf8ba4a15c548accab512423264b782e9ec047936d4c74f03f4970a606fd3::zomomo {
    struct ZOMOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMOMO>(arg0, 6, b"ZOMOMO", b"The Zomomo", b"Zomomo is a curious, playful character who loves to explore and find new challenges. So it came to Web3 to find new partners to build a beautiful home together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihezn2xgxf5khov33twbqmru6i7rgsjwkrdr7ghxrx74mdhz4pnym")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZOMOMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

