module 0x983a7872d4f0cc1cf9edf57f18aac357c614628061ea8adaae5f20ed1bfa64f0::bullboss {
    struct BULLBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c4a495f26a7cf881fb2e9b80efbf845e164c25e805602072d0b998f66f6bfdaf                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BULLBOSS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Bullboss    ")))), trim_right(b"Bull Boss                       "), trim_right(x"2442756c6c426f7373204d61646520666f7220444547454e532077686f2063616e2774207761697420666f722042756c6c2052756e0a0a4c6971756964697479204c6f636b65640a44657820416473204c6976650a0a57652041696d20746f204869742031304d206d696e696d756d20696e206e65787420323420686f757273202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLBOSS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLBOSS>>(v4);
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

