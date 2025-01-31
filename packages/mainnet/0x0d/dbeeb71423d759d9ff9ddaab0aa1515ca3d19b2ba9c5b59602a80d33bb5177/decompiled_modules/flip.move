module 0xddbeeb71423d759d9ff9ddaab0aa1515ca3d19b2ba9c5b59602a80d33bb5177::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C9kzHGduZtVQ5v5g6asT7fuGsikBkbN7YVQm8Hn1pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FLIP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FLIP        ")))), trim_right(b"FLIP                            "), trim_right(x"464c49502028464c4950290a464c49503a204120636f6d6d756e6974792d626173656420617070207468617420616c6c6f777320757365727320746f2073686f702c2063726561746520766964656f20726576696577732c20616e64206561726e206d6f6e65792e2055736572732063616e206561726e206d6f6e65792062792073686172696e6720746865697220657870657269656e63657320776974682070726f647563747320616e64206279206372656174696e6720766964656f20726576696577732e204f74686572732063616e20616c736f206561726e206d6f6e657920627920627579696e672070726f6475637473206261736564206f6e20746865736520726576696577732e2024464c495020536f6c616e6120746f6b656e20697320616e20696e646570656e64656e7420656e646561766f722c20636f6e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v4);
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

