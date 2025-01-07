module 0xd228bda76f39fab24051be88a2afe75d52e55cd62f191358c7438c233c2701c7::mootoshi {
    struct MOOTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOTOSHI>(arg0, 6, b"Mootoshi", b"Mootoshi Nakamodeng", x"54686520626967676573742072657665616c20696e2074686520656e746972652063727970746f73706163652120546865207265616c205361746f736869204e616b616d6f746f2120546865206c61636b206f6620636f6d6d756e6974792066726f6d207468652070617374207965617273206973207374617274696e6720746f206d616b652073656e7365206e6f772e20496d6167696e65207468652067656e69757320626568696e6420426974636f696e2069732061637475616c6c7920616e20696d6d6f7274616c20686970706f2070726574656e64696e6720746f2062652061206e6f726d616c20616e696d616c20696e2061207a6f6f2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6062377412848630839_x_1_d899119dfa_c787b1e64f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

