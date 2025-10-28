module 0x5dd9ccffcd78276e2855c52db92d238b7d89f7405cc17a1ca9916089b9c5361::pepeloco {
    struct PEPELOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPELOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5f0dda3c91abc58c47df17538dadc70f077c8f76c6fd33ec465f89d8a547a879                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPELOCO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPELOCO    ")))), trim_right(b"PEPELOCO                        "), trim_right(x"53746172746564206f757420736c696e67696e67206d616e676f7320616e64207461636f73206f6e2074686520636f726e65722020206a75737420612068617264776f726b696e672066726f6720747279696e6720746f206d616b652072656e7420616e6420627579206f6e6520636f6c6420446f73204571756973202e205468656e20736f6d656f6e6520736169642c2042726f2c2065766572206865617264206f662063727970746f3f200a0a4e657874207468696e6720796f75206b6e6f772c2049206c61756e636865642024504550454c4f434f206f6e20536f6c616e6120207468652066697273742066726f6720746f6f206c6f636f20666f72204943452020746f2063617463682e2054686579206265656e2063686173696e67206d79206261677320657665722073696e63652c2062757420496d20616c7265"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPELOCO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPELOCO>>(v4);
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

