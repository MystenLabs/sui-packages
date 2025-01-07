module 0xa5fdd54153dda46ec3101000de4b28042ab8827f3a4257cff66c3f002dfa5f7e::lou {
    struct LOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOU>(arg0, 6, b"LOU", b"LOU ON SUI", x"57657265206865726520746f2067697665206d656d652063756c74757265206120666163652c206120736f756c2c20616e64206120737061726b206f6620706c617966756c20726562656c6c696f6e2e204e6f206c6966656c65737320636f696e732c206e6f20656d7074792070726f6d697365736a75737420656e646c6573732066756e2c20637265617469766974792c20616e64206120776f726c64207768657265206469676974616c206d69736368696566206d65657473207265616c2d776f726c6420696d706163742e0a0a5374617920244c4f552d6c6c69736821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOU_64e5776d2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

