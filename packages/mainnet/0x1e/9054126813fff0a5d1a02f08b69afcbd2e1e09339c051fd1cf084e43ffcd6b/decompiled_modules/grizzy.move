module 0x1e9054126813fff0a5d1a02f08b69afcbd2e1e09339c051fd1cf084e43ffcd6b::grizzy {
    struct GRIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIZZY>(arg0, 6, b"GRIZZY", b"GRIZZY BEAR", x"244752495a5a59206a7573742077616e747320746f20626520746865206e65787420676f6f64207468696e672e2053696d706c652e2046756e2e204368696c6c2e205a65726f206f76657270726f6d697365732e204a7573742062656163682c20627265657a652c20616e642062656c6965766572732e0a0a4c6574207468652062656172206f75742e204c657420746865206d61726b6574206665656c2074686520636c6177732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiba5jplcrv64ygiolfe4idfr2leg6ymqaq7yty2zdznymdq4qidkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRIZZY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

