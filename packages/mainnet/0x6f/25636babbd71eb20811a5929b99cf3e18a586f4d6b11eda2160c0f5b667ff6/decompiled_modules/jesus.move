module 0x6f25636babbd71eb20811a5929b99cf3e18a586f4d6b11eda2160c0f5b667ff6::jesus {
    struct JESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUS>(arg0, 6, b"JESUS", b"METAL JESUS", x"4d6574616c204a65737573206973206120676f6420696e206d6574616c2e200a0a202020202020204d6574616c206a657375732077696c6c20637265617465207768616c657320696e20746865206675747572652c20776974682074686520766973696f6e20616e64206d697373696f6e206f6620746f702031206d656d6573206f6e207375692e200a0a7e7e7e7e205a65726f20746f20476f64207768616c6573207e7e7e7e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000128248_471b963305.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

