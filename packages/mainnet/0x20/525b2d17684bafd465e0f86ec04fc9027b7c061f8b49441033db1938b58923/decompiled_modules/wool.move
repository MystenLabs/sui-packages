module 0x20525b2d17684bafd465e0f86ec04fc9027b7c061f8b49441033db1938b58923::wool {
    struct WOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOL>(arg0, 6, b"WOOL", b"Wool", x"574f4f4c2069732061207265766f6c7574696f6e617279206d656d65636f696e206275696c74206f6e207468652053756920626c6f636b636861696e2c20636f6d62696e696e672073696d706c69636974792c20636f6d6d756e6974792c20616e6420696d6d656e736520706f74656e7469616c20696e207468652063727970746f20776f726c642e20496e7370697265642062792074686520776f6f6c206f662073686565702c20574f4f4c20776173206372656174656420746f2073796d626f6c697a6520756e69747920616e6420746865206a6f75726e657920746f7761726420737563636573732e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046589_734a88e238.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

