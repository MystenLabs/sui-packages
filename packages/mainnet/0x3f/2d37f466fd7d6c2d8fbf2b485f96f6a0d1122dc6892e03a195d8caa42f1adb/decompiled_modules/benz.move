module 0x3f2d37f466fd7d6c2d8fbf2b485f96f6a0d1122dc6892e03a195d8caa42f1adb::benz {
    struct BENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENZ>(arg0, 6, b"Benz", b"Mercedes", x"224c6f7665206f6620696e76656e74696f6e2077696c6c206e6576657220656e642e22202d204361726c2042656e7a0a48656c6c6f2065766572796f6e6521204920616d2061205068442073747564656e742066726f6d204765726d616e792c20616e64206166746572206d792073747564696573204920616d20676f696e6720746f2074616b65207570206120706f736974696f6e206174204d657263656465732d42656e7a2e2041206368616e636520656e636f756e7465722077697468204d454d45206f6e207468652053554920636861696e2073686f776564206d6520686f772070617373696f6e6174652065766572796f6e6520697321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Sf_VFQA_400x400_9333f41e85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

