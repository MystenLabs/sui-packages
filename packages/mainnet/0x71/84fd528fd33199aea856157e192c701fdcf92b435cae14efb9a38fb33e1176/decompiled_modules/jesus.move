module 0x7184fd528fd33199aea856157e192c701fdcf92b435cae14efb9a38fb33e1176::jesus {
    struct JESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUS>(arg0, 6, b"JESUS", b"METAL JESUS", x"2020202020202020202020204d6574616c206a65737573206f6e207375690a20202020202020202020204d656d6520636f696e20676f64206a657375730a6d6574616c206a657375732077696c6c20637265617465207768616c657320696e20746865206675747572652c20776974682074686520766973696f6e20616e64206d697373696f6e206f6620746f702031206d656d6573206f6e207375690a0a7e7e7e7e7e2046726f6d207a65726f20546f20676f64207768616c657320636f6d6d756e6974797e7e7e7e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000128248_213ad2f47f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

