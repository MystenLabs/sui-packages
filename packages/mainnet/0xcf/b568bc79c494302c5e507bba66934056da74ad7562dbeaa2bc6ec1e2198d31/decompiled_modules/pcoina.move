module 0xcfb568bc79c494302c5e507bba66934056da74ad7562dbeaa2bc6ec1e2198d31::pcoina {
    struct PCOINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCOINA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"vS6hizmfnVjS6kvl                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PCOINA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PCOIN       ")))), trim_right(b"People's Coin                   "), trim_right(x"574859202450434f494e0d0a596f7520616c6c207469726564206f6620727567732e2e2e20616e64207469726564206f6620727567732074656c6c696e6720796f75207468657920617265207469726564206f6620727567732e2057697468202450434f494e2c20697420697320757020746f20796f752c2074686520636f6d6d756e6974792c20746f2064657465726d696e65207468652066757475726520796f7572206675747572652e204f6e6c792074686520746f6b656e2c20776562736974652f646f6d61696e2c20616e642058206163636f756e742077696c6c20626520637265617465642e0d0a0d0a576861742068617070656e73206e6578743f20546861742077696c6c20626520757020746f20796f752c2074686520636f6d6d756e6974792e2054686973206973206e6f7420616e206578706572696d65"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCOINA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCOINA>>(v4);
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

