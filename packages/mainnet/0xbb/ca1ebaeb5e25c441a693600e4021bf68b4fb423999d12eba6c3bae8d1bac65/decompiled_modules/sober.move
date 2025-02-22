module 0xbbca1ebaeb5e25c441a693600e4021bf68b4fb423999d12eba6c3bae8d1bac65::sober {
    struct SOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"j0ab5Ya3h89Ra6sq                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOBER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOBER       ")))), trim_right(b"Sober coin                      "), trim_right(x"54686520466972737420506f736974697665204d656d65636f696e3a2041204d6f76656d656e742c204e6f74204a757374206120546f6b656e2e0d0a0d0a4974732074696d6520666f722061206368616e67652e20466f7220746f6f206c6f6e672c2074686520776f726c64206f66206d656d65636f696e7320686173206265656e2066696c6c6564207769746820656d7074792070726f6d697365732c207363616d732c20616e64206d65616e696e676c65737320687970652e204275742077652062656c6965766520696e20736f6d657468696e67206269676765726120636f6d6d756e697479206275696c74206f6e20706f73697469766974792c20707572706f73652c20616e64207265616c20696d706163742e0d0a0d0a416464696374696f6e20697320657665727977686572652e2044727567732c20616c636f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOBER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOBER>>(v4);
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

