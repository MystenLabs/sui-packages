module 0xee590930d3d17caccf78987db3e771430e73064c52c3aa8c71d813e4540db075::fiatxgld {
    struct FIATXGLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIATXGLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1df8605ed2614b7f72f7c16a6f2c19b79064b3eea5f58fcc4012524255f151d3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FIATXGLD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FIATXGLD    ")))), trim_right(b"FIATXGOLD                       "), trim_right(x"41206d656d6520636f696e2077697468207265616c2d776f726c64207368696e652e2057652066757365206469676974616c206368616f73207769746820676f6c64656e206c6f67696320206f757220746f6b656e20737570706c79206275726e7320617320676f6c647320707269636520636c696d62732e205768656e20676f6c642070726963657320726973652c20737570706c79206465637265617365732c20616e6420796f75722062616773206265636f6d652072617265722e205475726e696e67206d61726b6574206d6f76657320696e746f206d656d65206d616769632c206f6e65206275726e20617420612074696d652e0a41206d656d626572206f662056616c7565436f696e7320446576656c6f70657273204d656d6520436f696e2045636f73797374656d2e2020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIATXGLD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIATXGLD>>(v4);
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

