module 0x446664dd364c6a424df1aef66a18e75dcd0849eca8d016ca96aa6c5087a8e575::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6fUwECXzRQeh2wYuTg3xeQHGt4wSbiUbsdd1PYw3pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CT          ")))), trim_right(b"Crypto Twitter                  "), trim_right(x"546865204f4646494349414c2043727970746f205477697474657220546f6b656e206f6e20536f6c616e612e0a0a43727970746f205477697474657220546f6b656e2028244354292069732074686520656e6467616d6520666f722063756c742f63756c7475726520636f696e732120204173206d6f73742063756c7475726520636f696e7320617265206275696c74206f6e2063756c747572616c206661647320746861742077696c6c206576656e7475616c6c792064696520646f776e20616e64206265206d6f766564206f6e2066726f6d2c20435420726570726573656e7473207468652063756c74757265206f662043727970746f205477697474657220204f6e652077697468206120747261636b207265636f7264206f662031302b207965617273207468617420697320746865206e756d626572203120706c61"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CT>>(v4);
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

