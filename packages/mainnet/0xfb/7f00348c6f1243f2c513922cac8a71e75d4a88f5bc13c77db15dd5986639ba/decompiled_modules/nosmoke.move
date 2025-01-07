module 0xfb7f00348c6f1243f2c513922cac8a71e75d4a88f5bc13c77db15dd5986639ba::nosmoke {
    struct NOSMOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOSMOKE>(arg0, 6, b"NoSmoke", b"Stop Smoking", x"446f6e74206275792069742c2069742773206a75737420616e64206164766963650a4e6f20747769747465722c206e6f207765622c206e6f20636f6d6d756e6974792c206e6f7468696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000148555_86d6c4e926.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOSMOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOSMOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

