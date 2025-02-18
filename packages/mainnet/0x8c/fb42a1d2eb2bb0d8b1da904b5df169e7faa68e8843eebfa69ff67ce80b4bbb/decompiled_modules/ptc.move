module 0x8cfb42a1d2eb2bb0d8b1da904b5df169e7faa68e8843eebfa69ff67ce80b4bbb::ptc {
    struct PTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1ZN3X8OZyodSS2ST                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PTC         ")))), trim_right(b"PetitionCoin                    "), trim_right(b"How Can You Join? 1 Sign the Petition  Your signature = your vote for financial freedom! 2 Buy & HODL PTC  Strong hands get rewarded! 3 Spread the Word  The more people sign, the bigger we grow!  One signature, one buy, one moon. This isnt just a token, its a movement. Will you be part of the 10M club?  Join us NOW & L"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTC>>(v4);
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

