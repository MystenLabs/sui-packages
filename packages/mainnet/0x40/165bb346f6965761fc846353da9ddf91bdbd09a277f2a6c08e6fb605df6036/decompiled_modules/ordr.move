module 0x40165bb346f6965761fc846353da9ddf91bdbd09a277f2a6c08e6fb605df6036::ordr {
    struct ORDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORDR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"96434f749ee90b0d1cb3a14f047acca24d9d206bd72b559c3a1f088b2a3d383c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ORDR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ORDR        ")))), trim_right(b"OrderUp!!                       "), trim_right(x"5765277265206578636974656420746f20616e6e6f756e6365207468652072656c61756e6368206f66204f72646572557020436f696e210a4f7572206d697373696f6e20697320746f206275696c642061207374726f6e6765722c206d6f726520656e676167656420636f6d6d756e697479207768696c6520636f6e74696e75696e6720746f2067726f7720616e6420696e6e6f766174652e20546f2063656c6562726174652065616368206d696c6573746f6e652c20776527726520686f7374696e67206769766561776179732065766572792074696d652077652072656163682061206e6577206d61726b65742063617020676f616c0a4f6e65206c75636b790a686f6c6465722077696c6c2062652072616e646f6d6c792073656c65637465642066726f6d206f757220636f6d6d756e69747920746f2077696e212020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORDR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORDR>>(v4);
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

