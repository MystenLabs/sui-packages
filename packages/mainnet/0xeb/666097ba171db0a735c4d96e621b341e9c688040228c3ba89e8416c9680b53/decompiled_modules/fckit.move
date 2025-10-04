module 0xeb666097ba171db0a735c4d96e621b341e9c688040228c3ba89e8416c9680b53::fckit {
    struct FCKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"70cd8a91765e46c286bf5f0a08b75423a80f326a9eb0d0115d515704206fe91f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FCKIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Fckit       ")))), trim_right(b"Fckit                           "), trim_right(x"66636b2069742a206973206d6f7265207468616e206120636f696e2c206974732061206d696e647365742e0a466f7220746865207269736b2d74616b6572732c2074686520646567656e732c2074686520647265616d6572732e204c6567656e6473206172656e74206d61646520627920706c6179696e6720697420736166652c20746865797265206d61646520627920736179696e672066636b2069742a20616e6420676f696e6720616c6c20696e2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCKIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCKIT>>(v4);
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

