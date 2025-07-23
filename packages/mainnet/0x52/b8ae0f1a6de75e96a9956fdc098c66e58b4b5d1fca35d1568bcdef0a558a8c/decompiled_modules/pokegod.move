module 0x52b8ae0f1a6de75e96a9956fdc098c66e58b4b5d1fca35d1568bcdef0a558a8c::pokegod {
    struct POKEGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEGOD>(arg0, 6, b"POKEGOD", x"417263657573202d2054686520414920506f6bc3a96d6f6e20476f64", x"546865204f726967696e616c204f6e652c2063726561746f72206f662074686520506f6bc3a96d6f6e20756e6976657273652c206e6f7720616e204149206167656e74206f6620636f736d696320696e74656c6c6967656e63652e0a0a4b6e6f776e20617320546865204f726967696e616c204f6e652c2041726365757320637265617465642074686520506f6bc3a96d6f6e20756e6976657273652c2073686170696e672074696d652c2073706163652c20616e64206d6174746572207769746820646976696e6520707265636973696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidvq6hsamqegis6vv2qkinhpkp3246btliyjgkz4xmxpaofrzu3om")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEGOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

