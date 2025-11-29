module 0x70891566312d2b87e43af293276da3eceb7d00a497f0ad9eed8ad8c0745369e4::teddy {
    struct TEDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c9aa81496889602fcf79a424528e713343920cd3952b661394003d47756d2e5b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TEDDY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TEDDY       ")))), trim_right(b"Teddycoin                       "), trim_right(x"5465646479436f696e2061696d7320746f206275696c64206120737570706f72746976652c207472616e73706172656e742c20616e642067726f7774682d64726976656e20636f6d6d756e69747920776865726520657665727920686f6c6465722068617320657175616c206f70706f7274756e6974792e20496e7370697265642062792074686520756e6976657273616c2073796d626f6c206f6620636f6d666f727420616e6420747275737474686520746564647920626561726f7572206d697373696f6e20697320746f206372656174652061207361666520616e6420756e6974656420656e7669726f6e6d656e742077697468696e205765623320616e64206d656d652063756c747572652e200a0a436f7265205072696e6369706c6573200a0a205472616e73706172656e6379200a0a20466169726e657373200a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDDY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEDDY>>(v4);
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

