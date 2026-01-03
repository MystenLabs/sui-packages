module 0x9e7418ee528d661e13ab50c65ccb12350e3f18c934e5205a929a2a8df3ec7031::jdsg {
    struct JDSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDSG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/l1twPUsGvZEfCThgeD8qEkZrGmGGRmY5c98ot7bS2NY";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/l1twPUsGvZEfCThgeD8qEkZrGmGGRmY5c98ot7bS2NY"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<JDSG>(arg0, 9, trim_right(b"JDSG"), trim_right(b"JDSGD"), trim_right(b"JD Stablecoin"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JDSG>>(0x2::coin::mint<JDSG>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDSG>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JDSG>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JDSG>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

