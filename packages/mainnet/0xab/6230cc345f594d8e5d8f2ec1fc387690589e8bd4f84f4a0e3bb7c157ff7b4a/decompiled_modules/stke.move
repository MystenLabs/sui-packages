module 0xab6230cc345f594d8e5d8f2ec1fc387690589e8bd4f84f4a0e3bb7c157ff7b4a::stke {
    struct STKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cc70d1b973419d4a3e16b931ebdf1979c8cbd726ffae6c95b81cd1c65c08910e                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STKE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STKE        ")))), trim_right(b"Sol Strategies Inc              "), trim_right(x"534f4c205374726174656769657320617070726f76656420666f72204e61736461712045786368616e676520476c6f62616c2053656c656374204d61726b6574206c697374696e6720756e64657220746865207469636b65722053544b4520616e642074726164696e672077696c6c20636f6d6d656e6365206f6e20547565736461792c2053657074656d62657220392c203230323521200a0a546865204f47205469636b6572203a202453544b450a436f7272656374204e616d65203a20536f6c616e61205374726174656769657320496e63202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STKE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STKE>>(v4);
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

