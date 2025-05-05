module 0x67dea02bea9711a22a0ee71b078ec6bccbe19f0ebcc043a56bf40376baafef2c::tnn {
    struct TNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DzvWsz4eLG2i2326E81rFxjTqaa476khgPRpRzrcpump.png?claimId=iJWApRzMlShXSEu2                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TNN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TNN         ")))), trim_right(b"Trenches News Network           "), trim_right(x"546865206f726967696e616c2064657673206162616e646f6e6564207468652024544e4e20636f6e74726163742020627574207765206469646e742e0a0a54686973206973206120636f6d6d756e6974792d6c65642074616b656f766572206279207468652073616d65207465616d20626568696e64205472757468204669727374204d6564696120616e642024414e54592c206e6f77206c61756e6368696e67207468652066697273742043544f2028436f6d6d756e6974792054616b656f766572204f7065726174696f6e2920666f7220746865207472656e636865732e0a0a57697468206f766572203531304d20746f6b656e73207374696c6c20696e204c50207768656e20776520666972737420616e6e6f756e636564206f757220696e74656e74696f6e732c207765277265207265766976696e672024544e4e20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNN>>(v4);
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

