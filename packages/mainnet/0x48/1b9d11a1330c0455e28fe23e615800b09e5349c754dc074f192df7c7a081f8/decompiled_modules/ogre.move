module 0x481b9d11a1330c0455e28fe23e615800b09e5349c754dc074f192df7c7a081f8::ogre {
    struct OGRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGRE>(arg0, 6, b"OGRE", b"SuiOgre", x"476f64206f6620746865206f6365616e20636f6d657320746f2073686f772077686f2074686520746f7020776174657220506f6bc3a96d6f6e206973206f6e2053756921212120436f6d65207377696d2077697468206120476f6420616e642073686f772074686520776f726c6420776861742061207265616c207473756e616d6920697321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifluv27anwlz73sk4ggtqvcix5xuxmsfsahjlkxdnwmd4sy3mhlfe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OGRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

