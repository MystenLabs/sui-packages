module 0xe3aebd3d83461ff419f9c0c19d03c54a15399c258c31653f88e22f93a50eca92::colors {
    struct COLORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLORS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cf640079d79e4cec7f468f57aec9968026dae3f511ff390801f4590dbfe2f772                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COLORS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COLORS      ")))), trim_right(b"COLORS                          "), trim_right(x"434f4c4f5253206973206120636f6d6d756e697479206d656d65636f696e2074686174732067726f77696e6720657665727920646179206f6e20582c2054656c656772616d2c20616e6420446973636f72642c20776974682074776f204e465420636f6c6c656374696f6e732e0a596f752063616e207374616b6520796f757220434f4c4f5253204e46547320616e64206561726e2024434f4c4f5253206461696c7920212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLORS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLORS>>(v4);
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

