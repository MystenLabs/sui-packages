module 0x34fda68668c31da8fb7ba1a01922c730edd997e86051675a00e457f8294913a7::moonz {
    struct MOONZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"XYxHQRAZiHLjRXEO                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOONZ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOONZ       ")))), trim_right(b"MoonPetz                        "), trim_right(x"204d6f6f6e5065747a20284d4f4f4e5a29202054686520556c74696d61746520537061636520446f67676f20436f696e21200d0a0d0a4d6f6f6e5065747a206973207468652077696c64657374206d656d6520636f696e20696e207468652067616c6178792c20706f776572656420627920636f6d6d756e69747920687970652c20766972616c206d656d65732c20616e6420696e7465727374656c6c6172207574696c6974792120496e737069726564206279206c6567656e64617279206d656d6520636f696e73206c696b6520446f6765636f696e20616e6420536869626120496e752c204d6f6f6e5065747a2069732074616b696e672063727970746f207065747320746f20746865206d6f6f6e20616e64206265796f6e642e0d0a0d0a20576879204d4f4f4e5a2057696c6c20476f20566972616c3a0d0a20556c74"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONZ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONZ>>(v4);
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

