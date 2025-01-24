module 0xd4dba311d15f87eb6ce00e6337d2ea18106261be13884f1edbe600b5242dad8e::air3 {
    struct AIR3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"n1UqhmjoRiLWGLTt                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AIR3>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AIR3        ")))), trim_right(b"AIR3 Agent by AIRewardrop       "), trim_right(x"41495233204167656e74206973206d6f7265207468616e206120746f6b656e3b2069747320612072657365617263682d64726976656e20696e697469617469766520746f2063726561746520616e2041492d706f77657265642065636f73797374656d20776974682074616e6769626c65207574696c6974792c20616476616e636564206175746f6d6174696f6e2c20616e6420696e6e6f7661746976652066696e616e6369616c20696e746572616374696f6e73207468726f756768204149204167656e74732e0d0a0d0a536f6369616c20496e746567726174696f6e3a0d0a0d0a2d20547769747465723a2041495233204167656e74206175746f6e6f6d6f75736c7920706f7374732c20726573706f6e647320746f20746172676574656420746167732c20616e6420696e746572616374732077697468207573657273"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIR3>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIR3>>(v4);
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

