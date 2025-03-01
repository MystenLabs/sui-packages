module 0x42019f0cc610d7eb60842d4b730cfc99910df38d39bd0501ff61db0b8c538765::mcpepe {
    struct MCPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"Mk_Z-L0L4KwJfrz6                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MCPEPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MCPEPE      ")))), trim_right(b"McPepe                          "), trim_right(x"50657065206e65656473206d6f6e657920746f20627579206d6f726520636f696e732e204275742077686f20776f756c64206869726520612066726f672077686f7365206f6e6c7920657870657269656e63652069732063727970746f3f204d63446f6e616c64732c206f6620636f75727365210d0a0d0a5468696e677320617265206c6f6f6b696e6720676f6f64206174204d63446f6e616c647320666f7220506570652e204d6350657065206973206c61756e6368696e67206f6e20536f6c616e612c206d6f6465726e697a696e67207468652050657065206272616e642077697468206120636861696e2063617061626c65206f66206f76657220322c303030207472616e73616374696f6e7320706572207365636f6e6420666f72206c657373207468616e206f6e652063656e7420656163682e20416e6420506570"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCPEPE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCPEPE>>(v4);
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

