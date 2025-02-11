module 0x50f727b8991ab97ab27ec0717450963a6c178603a4f5dad7e89b8bb88cf28a20::xspa {
    struct XSPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8Hg96R1AGDe5vKABwniVPT2LHdhZHmCTFijZAXXZpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XSPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XSPA        ")))), trim_right(b"XSPA                            "), trim_right(x"5853504120436f696e3a205265766f6c7574696f6e697a696e6720414920546563686e6f6c6f6779207769746820426c6f636b636861696e0a0a5853504120436f696e20697320612063757474696e672d656467652063727970746f63757272656e63792064657369676e656420746f20706f77657220746865206e6578742067656e65726174696f6e206f662041492d64726976656e206170706c69636174696f6e732e204275696c74206f6e20612073656375726520616e64207363616c61626c6520626c6f636b636861696e2c205853504120436f696e20666163696c697461746573207365616d6c657373207472616e73616374696f6e732c20646174612065786368616e6765732c20616e6420696e63656e746976697a6174696f6e206d656368616e69736d7320666f7220414920646576656c6f706572732c20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSPA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XSPA>>(v4);
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

