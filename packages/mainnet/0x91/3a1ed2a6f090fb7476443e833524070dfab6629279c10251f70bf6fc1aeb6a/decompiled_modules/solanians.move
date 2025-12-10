module 0x913a1ed2a6f090fb7476443e833524070dfab6629279c10251f70bf6fc1aeb6a::solanians {
    struct SOLANIANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANIANS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"97f5017ac4d9ddaca9b1e7ae5461a158b9af8dcd4904adb21fc57db33e81d9d3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLANIANS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Solanians   ")))), trim_right(b"Solanians                       "), trim_right(x"536f6c616e69616e730a0a5468652050656f706c65206f6620536f6c616e612e200a546865204d656d652e200a546865204d6f76656d656e742e0a0a426f726e2066726f6d20536f6c616e612e20506f77657265642062792074686520536f6c616e69616e732e204120636f6d6d756e6974792d64726976656e206d6f76656d656e742063656c6562726174696e6720746865206964656e74697479206f6620536f6c616e61206e617469766573202d20617274697374732c206275696c646572732c20616e64206578706c6f72657273206f662074686520636861696e2e0a0a4275696c742066726f6d2074686520636f6c6c65637469766520656e65726779206f6620536f6c616e6127732063726561746976652065636f73797374656d2c20536f6c616e69616e732063656c65627261746520746865206964656e7469"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANIANS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLANIANS>>(v4);
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

