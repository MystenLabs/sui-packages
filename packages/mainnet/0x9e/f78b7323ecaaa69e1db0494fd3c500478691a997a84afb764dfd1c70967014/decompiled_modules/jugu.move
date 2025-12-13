module 0x9ef78b7323ecaaa69e1db0494fd3c500478691a997a84afb764dfd1c70967014::jugu {
    struct JUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8ac4c5a90a6c0357acaa95b1315782fee45e6203a7cbac7ebcbcfbb3843418e4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JUGU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JUGU        ")))), trim_right(b"Jugucoin                        "), trim_right(x"57656c636f6d6520746f204a756775436f696e2020746865206f6666696369616c206d656d65636f696e20696e73706972656420627920746865206c6567656e64617279204a75676f4a7567756c61697220656e657267792e0a426f726e2066726f6d2070757265206368616f732c2068756d6f722c20616e6420636f6d6d756e697479207370697269742c204a756775436f696e206973206865726520746f2074616b65206f76657220746865206d656d6520776f726c642e0a0a4a6f696e206561726c792e204c61756768206861726465722e204d656d6520746f6765746865722e0a244a5547552020506f77657265642062792070757265204a75677520656e657267792e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUGU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUGU>>(v4);
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

