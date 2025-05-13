module 0xd580204cbeea58f9f9699032323d94cfab05c95277468ab53469e0c16fa5a690::buttcheeks {
    struct BUTTCHEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTCHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Fz2ZfKDKVXiPEfZLPmrjegtXAKd9vygAZKPJ9fcKpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUTTCHEEKS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"buttcheeks  ")))), trim_right(b"buttcheekscoin                  "), trim_right(x"2042757474436865656b73436f696e202824425554542920697320746865207468696363657374206d656d6520746f6b656e206f6e2074686520626c6f636b636861696e202064657369676e656420746f20626f756e6365206861726420616e64207368616b65207570207468652073706163652e0a0a4675656c6564206279207075726520646567656e20656e6572677920616e64206120636f6d6d756e697479207468617473206e6f742061667261696420746f20776967676c652c2042757474436865656b73436f696e206973206865726520746f206272696e6720746865206c61756768732c20746865206761696e732c20616e642074686520636865656b792076696265732e0a0a4e6f2074617865732e204e6f2066696c746572732e204a7573742066756c6c2d73656e64206d6f6d656e74756d207769746820"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTCHEEKS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTCHEEKS>>(v4);
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

