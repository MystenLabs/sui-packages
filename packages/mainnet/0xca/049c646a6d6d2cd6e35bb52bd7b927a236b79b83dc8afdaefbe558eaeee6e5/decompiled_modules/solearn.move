module 0xca049c646a6d6d2cd6e35bb52bd7b927a236b79b83dc8afdaefbe558eaeee6e5::solearn {
    struct SOLEARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLEARN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5xLE19xaTWek8pviTcUPF9qkdWxfo2hrEUshM85GtsoZ.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLEARN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SolEarn     ")))), trim_right(b"SolEarn                         "), trim_right(x"352520746178202c20353025206261636b20746f2074686520686f6c64657220696e20536f6c616e61206a75737420666f7220686f6c64696e67200a23536f6c4561726e206973206a7573742074686520666972737420746f6b656e20696e20746865205472696c6f67792e0a50656f706c6520617265207265616c6973696e67207468617420746865204245535420746f6b656e7320746f20686f6c6420617265207468652070726f76656e206f6e65732e200a0a23534f4c414e41202023455448455245554d20616e64202342544320636f6e74696e756520746f20646f6d696e617465207468652063727970746f63757272656e637920737061636520736f2077652077696c6c206265207374617274696e6720776974682023534f4c414e41207265666c656374696f6e732e204d6f726520746f20636f6d652e2020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLEARN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLEARN>>(v4);
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

