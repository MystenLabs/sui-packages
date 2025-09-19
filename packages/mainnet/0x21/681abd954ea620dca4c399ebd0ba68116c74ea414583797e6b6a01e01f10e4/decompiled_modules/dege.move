module 0x21681abd954ea620dca4c399ebd0ba68116c74ea414583797e6b6a01e01f10e4::dege {
    struct DEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9f74fd49f637c0447e3f2931a6d19927f9cda0c1b01f1fae07734a4e331cfd88                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Dege        ")))), trim_right(b"DegeCoin                        "), trim_right(x"5765206172652024444547452046616d696c696121204f75722044454745206d6f76656d656e742069732061207265616c206465616c2120536f20646f6e277420626520736c656570696e67206f6e20746869732e200a54686973206973206e6f7420616e206f6666696369616c2043544f2c207765207468696e6b207468617420746865204465767320617265207374696c6c20776f726b696e6720626568696e6420746865207363656e65732874686174277320776879207765206b656570696e67207468656972205765627369746529204275742077652074616b696e67207468697320696e746f206f75722068616e647320736f2070656f706c6520646f6e277420676574207363616d6d656420627920616c6c207468656d207363616d6d65727321204445474520666f722074686f73652077686f207374617921"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGE>>(v4);
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

