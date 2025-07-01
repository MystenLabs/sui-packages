module 0x2ac99e0f0e379fe3c50e80e319cf36827693471a7a5cd388718212568ac08a07::please {
    struct PLEASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLEASE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Dx4wzpwy9yCtYTSyTpaiGa45CKt4hPWEDKv6Vafvpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PLEASE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Please      ")))), trim_right(b"Please do not sell              "), trim_right(x"506c6561736520646f206e6f742073656c6c2028506c65617365290a4974206d69676874206d616b652073656e7365206a75737420746f2067657420736f6d652024506c656173652020696e20636173652069742063617463686573206f6e2e20496620656e6f7567682070656f706c65207468696e6b207468652073616d65207761792c2074686174206265636f6d657320612073656c662d66756c66696c6c696e672070726f70686563792e222053696e636572656c79204445563a2040626f736e69616e646f74736f6c20207c2057696c6c2062652072756e6e696e672070726f6a65637420616e642077696c6c206265206c697665206f6674656e2e207c2057696c6c20757064617465204445585320617420737461727421207c2058206973206372656174656420616e64207665726966696564207c204d792070"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEASE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLEASE>>(v4);
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

