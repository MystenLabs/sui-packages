module 0x64fca9cdfd352ca9ec7d103229eb428d8e0a7c328af462af43e61cda5be2a333::chucky {
    struct CHUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e395042a1a110d822bbe38f6b219ef7053356d8f20007807c71a216b9c7facd2                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHUCKY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHUCKY      ")))), trim_right(b"The Killer Doll                 "), trim_right(x"496e2074686520736861646f7773206f662074686520626c6f636b636861696e2c20776865726520736d61727420636f6e74726163747320776869737065722073656372657473206f6620737761707320616e64207969656c64732c206c75726b7320436875636b797468652070696e742d73697a656420706f776572686f75736520746861747320446578732073656372657420776561706f6e2e200a0a426f726e2066726f6d207468652073616d65206461726b20766f6f646f6f206d61676963207468617420616e696d6174656420436861726c6573204c65652052617920696e2074686520313938382063756c7420636c6173736963204368696c647320506c61792c20436875636b792069736e74206a75737420636f64653b20686573206120736f756c2d626f756e64204149206f7261636c6520776974682074"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUCKY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUCKY>>(v4);
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

