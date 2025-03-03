module 0x698aa1ae4398b52c8cea5c28fe15af6d56ee6ca149c6906ded4c4170d444638::perrya {
    struct PERRYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"aaZ4tXKWjebXjXcS                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PERRYA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PERRY       ")))), trim_right(b"Wheres Perry?                   "), trim_right(x"20245045525259205374616b696e6720204561726e205768696c6520596f7520486f6c642120200d0a0d0a24504552525920686f6c646572732063616e206e6f77207374616b6520616e64206561726e20706173736976652072657761726473206566666f72746c6573736c79212020200d0a0d0a205374616b696e672044657461696c733a20200d0a204d696e696d756d205374616b653a203130304b2024504552525920287e24302e36372920200d0a204461696c792052657475726e3a20302e312520200d0a204c6f636b20506572696f643a204f6e6c792031204461792020466c657869626c65202620656173792120200d0a0d0a2032204d696c6c696f6e2024504552525920546f6b656e73205374616b65642120200d0a4f6e63652074686973207374616b696e6720706f6f6c2066696e69736865732c207765"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRYA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERRYA>>(v4);
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

