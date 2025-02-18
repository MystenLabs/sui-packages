module 0xac0187aeb452af06c7cb9ced36b281780ab4ee3c61042a74436e66b02becf817::yupfun {
    struct YUPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4cp9JPLZBEAvw6KQbfxnQEEVHVd7wne1gD8FEZKupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YUPFUN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YUPFUN      ")))), trim_right(b"YUPFUN Token                    "), trim_right(x"2054686520447261676f6e277320416476656e747572653a20412054616c65206f66204c69717569646974792c20496e7465726f7065726162696c6974792c20616e6420496e6e6f766174696f6e200a0a4a6f696e2059757046756e2c20746865206d696768747920647261676f6e206f6620536f6c616e612c206f6e20616e20657069632031382d63686170746572206a6f75726e6579207468726f7567682074686520626c6f636b636861696e207265616c6d212046726f6d206177616b656e696e6720696e20746865206c616e64206f6620536f6c616e6120746f20636f6e71756572696e67207468652043726f73732d436861696e204272696467652c206578706c6f72696e672074686520452d436f6d6d65726365204b696e67646f6d2c20616e6420626174746c696e672074686520536c697070616765204d6f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUPFUN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUPFUN>>(v4);
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

