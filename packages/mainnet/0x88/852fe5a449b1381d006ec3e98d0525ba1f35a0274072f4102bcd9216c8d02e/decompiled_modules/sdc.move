module 0x88852fe5a449b1381d006ec3e98d0525ba1f35a0274072f4102bcd9216c8d02e::sdc {
    struct SDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4pwIECzc5vepSE9_                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SDC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SDC         ")))), trim_right(b"SolDegens.Club                  "), trim_right(x"536f6c446567656e732e436c75622c207768657265207765207475726e206c696665277320776f727374206465636973696f6e7320696e746f2070726f737065726974792120486572652c2077652063656c6562726174652074686520617274206f66206d616b696e67207465727269626c652063686f69636573202d2066726f6d20626c6f77696e6720796f7572206c69666520736176696e6773206f6e2070756d7066756e2c20746f2063686f6f73696e672074657175696c612073686f747320616e6420626f6e6720726970732c206f76657220627265616b666173742e200d0a0d0a5765277265206120636f6d6d756e69747920626f756e64206279206f757220736861726564206c6f766520666f722066696e616e6369616c207265636b6c6573736e6573732c207175657374696f6e61626c6520737562737461"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDC>>(v4);
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

