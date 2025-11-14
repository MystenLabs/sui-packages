module 0x8ba88adf9f79a7c2cf24c83edf60ccf2f6a53d939cf03a7c05b6675c53a96162::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"59dccadaa7ad4ba6f00a94f150f5555aefd204fc8944fd412408c5a0c1110f30                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAD         ")))), trim_right(b"MadDegen                        "), trim_right(x"244d414420284d6164446567656e2920205468652077696c6465737420636f6d6d756e697479206f6e2d636861696e2e204275696c7420627920646567656e732c20666f7220646567656e732e0a0a4a6f696e20746865204d6164446567656e2066616d20776865726520686f6c646572732061637475616c6c79206561726e202066726f6d20636f6d6d756e69747920726577617264732c2061697264726f70732c20636f6d70732c20616e6420626f74207061796f7574732e20576520646f6e74206a75737420687970652069742c207765206c6976652069742e20537461636b20796f757220244d41442c206561726e20776974682074686520637265772c20616e6420726964652077697468206f6e65206f6620746865207374726f6e676573742c206d6f7374206c6f79616c20646567656e20636f6d6d756e6974"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAD>>(v4);
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

