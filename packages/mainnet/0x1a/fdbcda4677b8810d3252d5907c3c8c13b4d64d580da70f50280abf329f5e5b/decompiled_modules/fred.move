module 0x1afdbcda4677b8810d3252d5907c3c8c13b4d64d580da70f50280abf329f5e5b::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"g1CgzxDEDt30HW2Q                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FRED>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FRED        ")))), trim_right(b"FRED                            "), trim_right(x"46726564202846524544292069732061207075726520536f6c616e612065636f73797374656d20746f6b656e2064657369676e656420666f72207365616d6c657373204465466920657870657269656e6365732e204275696c74206578636c75736976656c7920666f7220534f4c2d6261736564207472616e73616374696f6e732c204652454420636f6d62696e657320696e7374616e742073776170732c207374616b696e6720726577617264732c20616e64206d696e696d616c206665657320696e746f20612073747265616d6c696e656420706c6174666f726d2e200d0a0d0a4f75722073696e676c652d636861696e20666f637573206f6e20536f6c616e6120656e7375726573206c696768746e696e672d666173742073706565647320616e64206d6178696d756d20656666696369656e63792c206d616b696e67"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRED>>(v4);
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

