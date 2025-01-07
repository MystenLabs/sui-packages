module 0x80e8073df2f701e9dd00e22bc289d862864d07423ed7084efd7354d0af79e257::seiro {
    struct SEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEIRO>(arg0, 6, b"SEIRO", b"Seiro", x"4d65657420536569726f2c2074686520667572727920667269656e64206c6f76656420627920616c6c2c2074686520656d626f64696d656e74206f6620636f6d6d756e6974792c206a6f792c20616e64206d656d6573210a536569726f206973206d6f7265207468616e206a7573742061206375746520646f673b20697427732061207370656369616c20636f696e206f6e2074686520537569206e6574776f726b2074686174206272696e67732070656f706c6520746f6765746865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/received_1094519915418053_ce96595efb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

