module 0xfc930925189cc9cae9eff55ef7c8f73c19d4fb3543d50350819334c645d848f::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"h5HYcJXoc990BHbr                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STRUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STRUMP      ")))), trim_right(b"Space X Trump                   "), trim_right(x"576861742773206e65787420666f72205472756d703f2048652773206120627573696e657373207479636f6f6e20616e642074686520707265736964656e74206f662074686520556e69746564205374617465732074776963652e204e61747572616c6c792c20746865206e657874207374657020697320636f6e71756572696e672073706163652e204c65742773206261636b2074686174206d697373696f6e20616e64206d616b6520736f6d65206d6f6e657920616c6f6e6720746865207761792e2020546f20746865206d6f6f6e2c20796f75207361793f20492073617920617965210d0a0d0a536f6369616c206d656469612c20612054776974746572204149206167656e742c20616e642061207765627369746520636f6d696e6720736f6f6e202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRUMP>>(v4);
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

