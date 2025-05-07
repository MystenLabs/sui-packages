module 0xf6efa3f63e947b646cb712d7fb5faf04a499135cee478f09b8c89146c1de6db6::guysui {
    struct GUYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUYSUI>(arg0, 6, b"Guysui", b"The Real Sui Guy", x"4920616d2061207265616c20706572736f6e20616e642061207265616c206d656d6520676f642e0a6f6e6c79206275792066726f6d2070696e6e65642063612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3jtj5l4d6inhj6ervjyqupl2n3btwy2grmfu2iqonycs3ok4pxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUYSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

