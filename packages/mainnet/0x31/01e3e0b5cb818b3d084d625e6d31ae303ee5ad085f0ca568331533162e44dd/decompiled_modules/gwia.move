module 0x3101e3e0b5cb818b3d084d625e6d31ae303ee5ad085f0ca568331533162e44dd::gwia {
    struct GWIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"Taj_ynajJHF7ER4j                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GWIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GWIA        ")))), trim_right(b"Guess Who I Am                  "), trim_right(x"496d206865726520746f206769766520796f75206120326e64206368616e63652e200d0a496d206865726520746f20646973636f76657220686f77206d616e79206f6620796f75207472756c792062656c6965766520696e206d652e200d0a4e6f206e65656420746f20696e74726f64756365206d7973656c662e200d0a416e6420666f722074686f73652077686f207265636f676e697a65206d652c206c6574206d6520636c61726966793a20746861742067657374757265207761736e742061204869746c65722073616c7574652e200d0a49742073796d626f6c697a656420746865207472616a6563746f7279206f6620686f77207468697320636f696e2069732064657374696e656420746f206c61756e636820737472616967687420746f20746865206d6f6f6e2e0d0a0d0a486176652046756e20616e6420646f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWIA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWIA>>(v4);
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

