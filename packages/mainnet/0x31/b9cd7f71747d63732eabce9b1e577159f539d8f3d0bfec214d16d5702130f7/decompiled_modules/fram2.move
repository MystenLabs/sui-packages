module 0x31b9cd7f71747d63732eabce9b1e577159f539d8f3d0bfec214d16d5702130f7::fram2 {
    struct FRAM2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAM2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7dppjqtFi5Qfy4BRKJ6khN3yxDbvQhgNJbAoeh13pump.png?claimId=8gPkw78zMWSaEaRP                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FRAM2>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Fram2       ")))), trim_right(b"Fram2                           "), trim_right(x"4120766973696f6e617279206d697373696f6e206c6564206279204368756e2057616e672c2063727970746f2062696c6c696f6e6169726520616e6420636f2d666f756e646572206f66206632706f6f6c20616e64207374616b65666973682e204672616d322077696c6c206265207468652066697273742068756d616e207370616365666c6967687420746f206f726269742045617274687320706f6c617220726567696f6e732c206f66666572696e67206120393020706f6c6172207472616a6563746f727920666f72207472756c7920756e697175652045617274682076696577732e0a0a4f76657220333520646179732c206120676c6f62616c2063726577206f6620666f75722077696c6c20636f6e647563742063757474696e672d65646765206578706572696d656e747320696e206d6963726f677261766974"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAM2>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRAM2>>(v4);
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

