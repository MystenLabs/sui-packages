module 0x104c9e4c478aaf93e2c6719e56467ffcb4c24f8e9d0cc6a6a7951aa842fce910::swifties {
    struct SWIFTIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIFTIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"LK2KcjORfyxhn29Y                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SWIFTIES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SWIFTIES    ")))), trim_right(b"Unofficial Taylor Swift Coin    "), trim_right(x"48657220757365206f662073796d626f6c7320616e6420696d616765727920686173206f6e6c792067726f776e206f7665722074696d652c20746f2074686520706f696e74207468617420696620796f75206c6f6f6b206465657020656e6f75676820696e746f20537769667420576f726c642c206865722066616e73207365656d2061732069662074686579206172652070726163746963616c6c7920737065616b696e6720616e6f74686572206c616e6775616765207769746820616262726576696174696f6e732c20636f6465642063617463687068726173657320616e64207265666572656e6365732074686174206f6e6c79207468657920756e6465727374616e642e200d0a5765206c6f766520796f7520736f206d75636821202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIFTIES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIFTIES>>(v4);
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

