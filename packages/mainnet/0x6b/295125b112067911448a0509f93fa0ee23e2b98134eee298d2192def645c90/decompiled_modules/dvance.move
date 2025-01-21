module 0x6b295125b112067911448a0509f93fa0ee23e2b98134eee298d2192def645c90::dvance {
    struct DVANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"-2C6Gy4YZjFssRNG                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DVANCE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"dvance  ")))), trim_right(b"Official Donald Vance           "), trim_right(x"446f6e616c6456616e636520436f696e2028244456414e4345290d0a0d0a4f6666696369616c20436f696e206f6620446f6e616c642056616e63653a2048616c66205472756d702c2048616c662056616e63652c20414c4c204d454d452e0d0a0d0a41726520796f7520726561647920746f206d696e7420686973746f72793f20244456414e4345206973207468652073617469726963616c2c20626c6f636b636861696e2d706f776572656420636f696e207468617473206865726520746f20756e697465207468652063727970746f20776f726c646f6e65206d656d6520617420612074696d652e205768657468657220796f75726520612066616e206f6620224d616b696e672043727970746f20477265617420416761696e22206f72206a757374206c6f7665206120676f6f64206c617567682c2074686973206973"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVANCE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DVANCE>>(v4);
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

