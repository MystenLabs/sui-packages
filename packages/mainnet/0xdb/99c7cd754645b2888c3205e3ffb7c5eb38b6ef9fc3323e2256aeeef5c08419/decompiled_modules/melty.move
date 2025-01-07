module 0xdb99c7cd754645b2888c3205e3ffb7c5eb38b6ef9fc3323e2256aeeef5c08419::melty {
    struct MELTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELTY>(arg0, 6, b"Melty", b"Melty.sh", x"4d656c74792e736820284d656c7479290a577269746520636f64652c20696e746572616374207769746820796f75722066696c652073797374656d2c2062726f77736520746865207765622c20616e6420656173696c792063686174207769746820646966666572656e74206c616e6775616765206d6f64656c73206f6e20796f7572206465736b746f702e20416c6c20696e206120626c617a696e672d66617374206e6174697665206170702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345634_abee3a9f7d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

