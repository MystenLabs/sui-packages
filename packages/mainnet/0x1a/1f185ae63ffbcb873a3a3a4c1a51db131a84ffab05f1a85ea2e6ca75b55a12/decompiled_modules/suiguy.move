module 0x1a1f185ae63ffbcb873a3a3a4c1a51db131a84ffab05f1a85ea2e6ca75b55a12::suiguy {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 6, b"SUIGUY", b"TheRealSuiGuy", x"4920616d2061207265616c20706572736f6e20616e642061207265616c206d656d6520676f642e0a6f6e6c79206275792066726f6d2070696e6e65642063612e20646f6e742066616c6c20746f6f207363616d6d65722e20776520617265206e6f74206c61756e6368207965742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3jtj5l4d6inhj6ervjyqupl2n3btwy2grmfu2iqonycs3ok4pxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

