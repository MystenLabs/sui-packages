module 0x6249feaa7522112eec1b0d9028900f5ed994748f01e724dc0fe03a214be485f1::nfl {
    struct NFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ny465e6gf39sqT9G                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NFL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NFL         ")))), trim_right(b"Official NFL Super Bowl         "), trim_right(x"4f6666696369616c204e464c20537570657220426f776c200d0a204f6666696369616c20537570657220426f776c203230323520436f696e20284e464c29202054686520556c74696d6174652047616d65204461792043727970746f21200d0a0d0a47657420726561647920666f72207468652062696767657374206576656e74206f662032303235626f7468206f6e20746865206669656c6420616e64206f6e2074686520626c6f636b636861696e2120537570657220426f776c203230323520436f696e20284e464c29206973206865726520746f206272696e672074686520746872696c6c2c2074686520687970652c20616e6420746865206d61646e657373206f662074686520537570657220426f776c20737472616967687420746f20796f75722077616c6c65742e205768657468657220796f75726520776174"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFL>>(v4);
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

