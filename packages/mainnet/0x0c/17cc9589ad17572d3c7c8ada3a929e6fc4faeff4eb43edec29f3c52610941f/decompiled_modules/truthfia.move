module 0xc17cc9589ad17572d3c7c8ada3a929e6fc4faeff4eb43edec29f3c52610941f::truthfia {
    struct TRUTHFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTHFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/39GNquFYvLsdGJnfGy3odKyzJ9bwfbzCkeJLnnKRfweG.png?claimId=uUDIEQlX7M99iYRE                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUTHFIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRUTHFI     ")))), trim_right(b"TRUTH.FI                        "), trim_right(x"4974732061207061726f647920666f722054727574682e46692e0a5472756d707320636f6d70616e7920544d5447206170706c69656420666f72206d756c7469706c652074726164656d61726b7320776974682074686973205469636b65722e0a5374726f6e67206e6172726174697665200a48697320636f6d70616e7920616464732054727574682e466920666f7220616c6c2063727970746f2072656c6174656420627573696e65737365732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUTHFIA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUTHFIA>>(v4);
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

