module 0x74542c1323179edf07b01af46f47a25f2c4729989c0b45c9e6d514a3cd23754e::defai {
    struct DEFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8Zx6ECj3Fia7NCPfEWLcgCrP22j7dyS5GdYHUsTkVUtS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEFAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DEFAI       ")))), trim_right(b"DEFAI                           "), trim_right(x"4465664149202824444546414929202054686520556c74696d6174652041492054726164696e6720537472617465677920506c6174666f726d202620546f6b656e0a0a57616e7420746f206561726e207768696c6520796f7520736c6565703f0a0a5468652044656641492074726164696e6720706c6174666f726d20656e61626c657320796f7520746f2073656c65637420612074726164696e672073747261746567792c206261636b746573742069742c20616e64206c65742069742072756e206175746f6d61746963616c6c7920696e20746865206261636b67726f756e642e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEFAI>>(v4);
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

