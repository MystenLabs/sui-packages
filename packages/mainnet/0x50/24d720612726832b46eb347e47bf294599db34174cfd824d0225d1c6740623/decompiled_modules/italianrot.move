module 0x5024d720612726832b46eb347e47bf294599db34174cfd824d0225d1c6740623::italianrot {
    struct ITALIANROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITALIANROT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BQX1cjcRHXmrqNtoFWwmE5bZj7RPneTmqXB979b2pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ITALIANROT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Italianrot  ")))), trim_right(b"Italian Brainrot                "), trim_right(x"7472616c616c65726f207472616c616c610a626f6d6261726469726f2063726f636f64696c6f0a54554e4754554e4754554e4754554e472053414855520a63617070756363696e612062616c6c6572696e610a74726970692074726f70610a63617070756363696e6f20617373617373696e6f0a626f6d626f6d62696e6920677573696e690a62727220627272207061746170696d0a6c6972696c69206c6172696c6120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITALIANROT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITALIANROT>>(v4);
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

