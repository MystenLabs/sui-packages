module 0x68efee2ebc70b9cec9b5fd39754699d9a0b828c74a4703addf0647be4a86cd75::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c09cc8667b393cc31b13db97fe5ed5cb9ae3f0c0283a072a2a40f931f48c04d9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GG          ")))), trim_right(b"GOODGAME                        "), trim_right(x"474f4f4447414d452028474729202074686520536f6c616e6120746f6b656e20706f776572696e672074686520476f6f6447616d652045636f73797374656d2e0a436f6d706574652c2077616765722c20616e64206561726e20696e20736b696c6c2d62617365642063727970746f2067616d65732077697468207265616c20726577617264732e0a55736520474720746f20706c61792c2047475720746f2077616765722c20616e64206561726e2053686172647320746f2072656465656d20666f722063617368206f72206d61726b6574706c616365206974656d732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GG>>(v4);
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

