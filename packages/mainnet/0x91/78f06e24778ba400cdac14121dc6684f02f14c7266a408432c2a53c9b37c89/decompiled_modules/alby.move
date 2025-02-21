module 0x9178f06e24778ba400cdac14121dc6684f02f14c7266a408432c2a53c9b37c89::alby {
    struct ALBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALBY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/31Jacx99W2ySxuNhiSX6uiTJLtHFEdWGqFgMrSEKpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ALBY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ALBY        ")))), trim_right(b"Albert II Coin                  "), trim_right(x"544849532049532041204c4f4e47205445524d2050524f4a4543542057495448205554494c4954592d204c6f6e672d7465726d20686f6c646572732077696c6c20726563656976652061697264726f7020726577617264732e2041732077652067726f772077652077696c6c20636f6e74696e756520746f20616464206d6f726520616e64206d6f7265207574696c6974792e2042555920414e4420484f4c442121200a0a24414c42592c20612063727970746f63757272656e637920746f6b656e2c207061797320686f6d61676520746f20416c626572742049492c20746865206669727374207072696d61746520696e2073706163652e2054686520636f6d6d756e69747920626568696e642024414c425920697320636f6d6d697474656420746f2070726f6d6f74696e672074686520636f696e20616e6420656e7375"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALBY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALBY>>(v4);
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

