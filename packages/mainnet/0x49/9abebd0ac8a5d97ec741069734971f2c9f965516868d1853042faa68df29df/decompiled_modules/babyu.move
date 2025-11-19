module 0x499abebd0ac8a5d97ec741069734971f2c9f965516868d1853042faa68df29df::babyu {
    struct BABYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"58393e13d93b24b6283affd523f5adf183190305482e77000b6cba22de8d8b7d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BABYU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BabyU       ")))), trim_right(b"BabyUnicorn                     "), trim_right(x"596f7572204368696c642773204d61676963616c20414920467269656e640a0a4261627955200a0a4f7572206170703a2042414259552e41505020200a0a546869732069736e2774206a757374206120746f792e2049742773206120636f6d70616e696f6e2e204f7572204149204261627920556e69636f726e206973206120736f66742c206875676761626c6520667269656e6420706f776572656420627920696e74656c6c6967656e7420746563686e6f6c6f6779202064657369676e656420746f3a0a54616c6b20616e6420726573706f6e6420746f206368696c6472656e20696e207265616c2d74696d650a546561636820616e64206775696465207468656d207468726f75676820736f6e67732c2073746f726965732c206c616e6775616765732c20616e642073696d706c6520636f6e63657074730a466f7374"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYU>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

