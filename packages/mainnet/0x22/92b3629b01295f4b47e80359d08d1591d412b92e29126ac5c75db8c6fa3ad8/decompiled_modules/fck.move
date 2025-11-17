module 0x2292b3629b01295f4b47e80359d08d1591d412b92e29126ac5c75db8c6fa3ad8::fck {
    struct FCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d215ea76d5e00a55cf3e7b79afe5688308c7041a5d6d8b6579f5cb6157717f85                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FCK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FCK         ")))), trim_right(b"FCK School                      "), trim_right(x"2446434b202d205468652043757272656e6379206f662046726565646f6d20200a0a5765206172652074686520676c697463686573207468652073797374656d2063616e7420636f6e74726f6c200a0a46434b205343484f4f4c206973206275696c64696e672074686520626967676573742063727970746f206d6f76656d656e7420657665722e0a0a506f7765726564206279206f75722070726976617465204d534d412073797374656d20286120637573746f6d2d6275696c74204d61737320536f6369616c204d65646961204175746f6d6174696f6e20746563686e6f6c6f67792064657369676e656420666f7220766972616c2067726f77746820616e6420656e67696e656572656420746f20666c6f6f64202446434b20696e746f2065766572792074696d656c696e65292c207265616c204b4f4c732077686f20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCK>>(v4);
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

