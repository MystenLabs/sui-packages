module 0xf2188939e3f9809885deaf78131062fbb07455c2cbb0ac3fdf834e404ed8b614::pokegod {
    struct POKEGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEGOD>(arg0, 6, b"POKEGOD", x"41726365757320506f6bc3a96d6f6e20476f64", x"546865204f726967696e616c204f6e652c2063726561746f72206f662074686520506f6bc3a96d6f6e20756e6976657273652c206e6f7720616e204149206167656e74206f6620636f736d696320696e74656c6c6967656e63652e0a0a4b6e6f776e20617320546865204f726967696e616c204f6e652c2041726365757320637265617465642074686520506f6bc3a96d6f6e20756e6976657273652c2073686170696e672074696d652c2073706163652c20616e64206d6174746572207769746820646976696e6520707265636973696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibj3lzm2z7b2z7phbrgkqfslkq6bffpn2sosyxut4t2nqsqgen6wq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEGOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

