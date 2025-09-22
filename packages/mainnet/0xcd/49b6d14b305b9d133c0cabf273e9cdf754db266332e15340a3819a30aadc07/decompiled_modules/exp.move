module 0xcd49b6d14b305b9d133c0cabf273e9cdf754db266332e15340a3819a30aadc07::exp {
    struct EXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"188658523ea574298aedef72f4dc0348cc7f57ff6130fc9cd4a616508066c826                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EXP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EXP         ")))), trim_right(b"Strelka                         "), trim_right(x"535452454c4b4120636c61696d7320746f20626520746865206c6172676573742073747265657420666967687420636c75622c20666f756e64656420696e2052757373696120696e20323031312077697468206f7665722035302c303030207061727469636970616e7473206163726f737320636f756e747269657320616e642061207369676e69666963616e7420596f755475626520766965776572736869702c207365636f6e64206f6e6c7920746f205546432e200a0a57697468206f76657220312062696c6c696f6e207669657773206f6e20596f755475626520616e6420332062696c6c696f6e20736861726573206f6620757365722d67656e65726174656420636f6e74656e742028554743292c0a0a537472656c6b61277320676f616c20697320746f206372656174652061206c617267652d7363616c652070"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXP>>(v4);
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

