module 0xeafde1185714d3f69a0dc664739b1d5b3e89f1abc8d37891e99147a81670eeaf::nasass {
    struct NASASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CGy3RJrv57VUdrAnzbjkr6QsTcvfA6aGKpKMDh77pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NASASS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NASASS      ")))), trim_right(b"NASASS                          "), trim_right(x"4e4153415353206973206120706c6174666f726d207468617420747261636b7320746865206c6f75646573742c20726f756e646573742c20616e64206d6f7374206f7574726167656f7573206d6f7665727320696e20746865206d61726b65742e2049742773206275696c7420666f722074686f73652077686f206b6e6f77207468617420626967206761696e7320636f6d6520776974682062696720636865656b732e0a5765206d6f6e69746f72207072696365207377696e6773207769746820707265636973696f6e2e0a4f757220696e746572666163652073686f7773207768696368206173736574732061726520636c617070696e6720746865206861726465737420206e6f20666c7566662c206a757374206d6f74696f6e2e0a496620697420626f756e6365732c2069747320747261636b65642e202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASASS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NASASS>>(v4);
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

