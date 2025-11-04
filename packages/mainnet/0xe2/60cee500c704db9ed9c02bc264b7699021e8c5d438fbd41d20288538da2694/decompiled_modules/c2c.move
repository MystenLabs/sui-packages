module 0xe260cee500c704db9ed9c02bc264b7699021e8c5d438fbd41d20288538da2694::c2c {
    struct C2C has drop {
        dummy_field: bool,
    }

    fun init(arg0: C2C, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cd62833debbe381562463913cd245affa27f1e6f20d2243483dcdccdb2ee1183                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<C2C>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"C2C         ")))), trim_right(b"Cache-to-Cache                  "), trim_right(x"41206e6577206672616d65776f726b2c2043616368652d746f2d43616368652028433243292c206c657473206d756c7469706c65204c4c4d7320636f6d6d756e6963617465206469726563746c79207468726f756768207468656972204b562d63616368657320696e7374656164206f6620746578742c207472616e7366657272696e6720646565702073656d616e7469637320776974686f757420746f6b656e2d62792d746f6b656e2067656e65726174696f6e2e200a0a497420667573657320636163686520726570726573656e746174696f6e73207669612061206e657572616c2070726f6a6563746f7220616e6420676174696e67206d656368616e69736d20666f7220656666696369656e7420696e7465722d6d6f64656c2065786368616e67652e0a0a546865207061796f66663a20757020746f203130252068"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C2C>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<C2C>>(v4);
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

