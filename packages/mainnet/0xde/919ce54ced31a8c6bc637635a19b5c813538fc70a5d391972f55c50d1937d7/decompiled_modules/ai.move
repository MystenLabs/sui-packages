module 0xde919ce54ced31a8c6bc637635a19b5c813538fc70a5d391972f55c50d1937d7::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8IYsBwHm_Bk-dgI2                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AI          ")))), trim_right(b"Alien Invasion                  "), trim_right(x"54686520416c69656e20496e766173696f6e206973206865726521204120746f6b656e20746861742773206f7574206f66207468697320776f726c642c207468697320746f702074696572206d656d65636f696e206272696e6773207468652068696c6172697479206f66206120636f76657274206578747261746572726573747269616c2074616b656f76657220726967687420746f20796f75722063727970746f2077616c6c65742e0d0a0d0a416c69656e20496e766173696f6e206973207468652066697273742045636f73797374656d20746f6b656e2066726f6d20436c6f776e576f726c642120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v4);
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

