module 0xe6421756ecb115bb6cd79df51002550edc56e0cc6135b5120cdb09ebd8dbd265::fudna {
    struct FUDNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"599ea67d638c0dd12f8ea082ef6e97beaf56fe03d8dfb13e1d41fe1dd6a5fd4d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FUDNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FUDNA       ")))), trim_right(b"FUDERNAKAMOTO                   "), trim_right(x"46756465724e616b616d6f746f2020746865206d7974686963616c20677561726469616e206f662063727970746f20636f6e76696374696f6e2e0a456e656d79206f66204655442e0a5768656e206f74686572732070616e69632c206865206d65646974617465732e0a5768656e206d61726b6574732063726173682c20686520616363756d756c617465732e0a486520646f65736e742066696768742066656172206865206572617365732069742e0a2346554445522020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDNA>>(v4);
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

