module 0x29d703f6a62545298002bb15fa4cfe33fff1e662d69b6a560d4115a601557698::legenda {
    struct LEGENDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGENDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5cUPpbnzaenWkksKZuMMZMVSVmpi92SWy9kEd5Wr8MzW.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LEGENDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LEGEND      ")))), trim_right(b"Legend                          "), trim_right(x"4c6567656e6473206172656e277420626f75676874202d2074686579277265206d696e7465642e200a0a244c4547454e4420204275696c7420666f722074686520426f6c642c204261636b656420627920566973696f6e2e0a244c4547454e44206973206d6f7265207468616e206120746f6b656e20206974732061206d6f76656d656e742e20456e67696e656572656420666f72207265616c207574696c69747920616e642064657369676e65642077697468206c6f6e672d7465726d207375737461696e6162696c6974792c20244c4547454e442069732074686520686561727462656174206f662061206e6578742d67656e2065636f73797374656d206275696c742061726f756e6420636f6d6d756e6974792c20696e6e6f766174696f6e2c20616e64206469676974616c206c65676163792e205768657468657220"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGENDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGENDA>>(v4);
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

