module 0xd9dc1d1d33a49d0656e49767604391b2efb2027d8e3173a00b92364713d78fe5::archie {
    struct ARCHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4GG1oKz3jNVmbDxrNMhKosANDQKq7AP49UTzJ5HUpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ARCHIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ARCHIE      ")))), trim_right(b"Archie the cigar poodle         "), trim_right(x"496e74726f647563696e67204172636869652074686520436967617220506f6f646c652a0a0a4d656574204172636869652c2074686520736d6f6f74686573742c206d6f7374206368617269736d617469632063616e696e6520696e20746865206d6574617665727365212054686973206d696e692062726f776e20706f6f646c652069732074726164696e6720696e2068697320646f67204172636869652074686520436967617220506f6f646c652069732061207374796c697368206d656d6520746f6b656e20626c656e64696e672068756d6f722c20636f6d6d756e6974792c20616e642063727970746f2067726f7774682e204a6f696e20746865207061636b2c20686176652066756e2c20616e64206c657473206d616b652062696c6c696f6e737768696c6520736d6f6b696e6720697420616c6c21200a0a0a41"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCHIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCHIE>>(v4);
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

