module 0xe87638855a9a3a8964d72174f1981e5b5a868e7be09fd32b84321f4921883fbf::jointhetg {
    struct JOINTHETG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOINTHETG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"u5y5JnNGLeLukzcH                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JOINTHETG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JoinTheTG   ")))), trim_right(b"Join The Telegram               "), trim_right(x"59657321205765206c61756e636865642061204d656d6520436f696e20746f206c61756e63682061206d656d6520636f696e21204a6f696e206f75722054656c656772616d20666f7220746865204d617263682031357468204d656d6520526f636b6574204c616273206c61756e6368212042652070617274206f66206f757220636f6d6d756e6974792066726f6d207468652073746172742e20200d0a0d0a2041626f75742055730d0a0d0a4174204d656d6520526f636b6574204c6162732c207765206c61756e6368206d656d6520636f696e7320616e6420686f737420636f6d6d756e6974792074616b656f766572732e204a6f696e207468652066756e2c206f6e65206c61756e636820617420612074696d65210d0a0d0a2041626f7574204f7572204c61756e636865730d0a0d0a205072652d4c61756e63682054"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOINTHETG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOINTHETG>>(v4);
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

