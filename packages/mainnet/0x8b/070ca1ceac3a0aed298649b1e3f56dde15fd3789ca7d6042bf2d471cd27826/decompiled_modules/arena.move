module 0x8b070ca1ceac3a0aed298649b1e3f56dde15fd3789ca7d6042bf2d471cd27826::arena {
    struct ARENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARENA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"b0463c2e14cea5f36a8f75c1759ba78e8cd3925fdc44af8d4b85505d3f311eb8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ARENA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Arena       ")))), trim_right(b"Alpha Arena                     "), trim_right(x"416c706861204172656e6120697320612070726f6a6563742077686572652036204c4c4d7320617265206163746976656c792074726164696e6720616761696e73742065616368206f7468657220696e2061207465737420746f2073656520686f77204c4c4d732074726164652c206c6561726e20616e64207468696e6b206175746f6e6f6d6f75736c792e0a0a436f6d6d756e69747920546f6b656e20666f7220416c706861204172656e61202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARENA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARENA>>(v4);
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

