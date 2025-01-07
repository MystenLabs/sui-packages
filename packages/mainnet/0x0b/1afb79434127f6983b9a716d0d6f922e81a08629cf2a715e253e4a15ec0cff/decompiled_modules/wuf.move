module 0xb1afb79434127f6983b9a716d0d6f922e81a08629cf2a715e253e4a15ec0cff::wuf {
    struct WUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUF>(arg0, 6, b"Wuf", b"WUF (WUF) CTO", x"5755462046616d2c20697427732074696d652e0a0a576520617265206e6f74206865726520746f206769766520796f75207468652073616d65206f6c642073747566662e2057652061726520746865206e6577207465616d20696e20636f6e74726f6c206f6620245755462c20616e6420776520617265206c656164696e67207468652043544f2077697468206f6e65206d697373696f6e2020746f2074616b65202457554620746f20746865206d6f6f6e20616e64206265796f6e6420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5291_98823e0ce3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

