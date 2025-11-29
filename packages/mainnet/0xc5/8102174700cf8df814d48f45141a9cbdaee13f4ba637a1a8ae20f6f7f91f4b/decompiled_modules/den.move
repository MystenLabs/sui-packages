module 0xc58102174700cf8df814d48f45141a9cbdaee13f4ba637a1a8ae20f6f7f91f4b::den {
    struct DEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"35584665d915d247aa890f9fe7a084b5d96de36516c454a3ed8b1249f21c83b8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DEN         ")))), trim_right(b"Don't Exit Now!                 "), trim_right(x"2444454e206973206120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e206275696c742061726f756e64206461696c792072757368206576656e747320696e20746865204d656d6576657273652e0a4974732064657369676e656420746f206372656174652073686f727420627572737473206f6620766f6c6174696c69747920776865726520686f6c646572732063616e20636f6d706574652c20636c61696d20726577617264732c20616e64207269646520746865206368616f7320746f6765746865722e204576657279206461792c202444454e20656e7465727320612074696d6564206576656e742077696e646f772020612067616d69666965642074726164696e6720657870657269656e63652074686174207475726e73206d61726b6574206d6f76656d656e7420696e746f20636f6d6d75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEN>>(v4);
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

