module 0x7fd63287741f4b1abcd7dd440279ec571f3bbedce0bb868393f31c009acf5dd6::sharmtawd {
    struct SHARMTAWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARMTAWD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"tiHvbTFODtofcDHJ                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHARMTAWD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHARMTAWD   ")))), trim_right(b"SHIBs Retawded Brother          "), trim_right(x"544845204445562057494c4c204e4f5420525547205448495320434f494e21200d0a0d0a57656c636f6d6520746f2053484942532061727461726465642062726f7468657220202824534841524d54415744292020546865204669727374204d656d65636f696e20506f77657265642062792031303025205075726520556e66696c74657265642044657270210d0a0d0a546869732069736e74206a757374206120746f6b656e2e20546869732069732061207265766f6c7574696f6e206f66207269646963756c6f75736e6573732e20536861726d746177642077617320666f7267656420696e2074686520666965727920646570746873206f6620696e7465726e65742061627375726469747920746f206265207468652073696c6c6965737420796574207374726f6e67657374206d656d65636f696e20746f20657665"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARMTAWD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARMTAWD>>(v4);
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

