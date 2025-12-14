module 0xd9792ac0e9f42ad1f393d0765bc7d6849cc7bf4d96a688415b98e3d58ca8a5::snoopy {
    struct SNOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"677be002c00d8caaf7ebfa08ac41053f996a1aaa13d095829ba3b57a03d941c9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SNOOPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Snoopy      ")))), trim_right(b"Snoopy                          "), trim_right(x"54686520436f6d6d756e69747920746f6f6b206f76657220746869732070726f6a656374206f6e2031322f31312f32352e20446576206861732031313120746f6b656e732c203220626f6e64656420616e64206162616e646f6e6564207468652070726f6a6563742e205468697320636f6d6d756e697479206c6f7665732024536e6f6f707920616e6420616c6c206f6620746865205065616e7574732066726f6d20436861726c6573204d2e20536368756c7a2c206120436172746f6f6e697374206f7574206f662053742e205061756c204d4e2e200a0a536e6f6f70792069732070617274206f6620746865205065616e7574732067616e6720616e6420666972737420617070656172656420696e2074686520636f6d6963207374726970206f6e204f6374203474682c20313935302e20536e6f6f7079207761732069"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPY>>(v4);
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

