module 0x6af157c0d221550478269f8697fd8d71a91af126f01a872cb7c0cb6558670dab::cpu {
    struct CPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3vPnCvrYU6xrWQj4xQqLtLeBzbiiYH4dLSoJQq2Lpump.png?claimId=VbWvMbPnwdKTlAcg                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CPU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CPU         ")))), trim_right(b"CUM PROCESSING UNIT             "), trim_right(x"244350552c20412043544f2070726f6a6563742061696d696e6720746f20646f6d696e6174652074686520416c206d656d6520657261612067656e65726174696f6e616c206d656d6520796f752063616e2774206d6973732e0a5765277265206865726520746f206265667269656e6420616c6c207468652061646f7261626c6520416c206167656e7473206f7574207468657265210a2361696f6e6c7966616e732020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPU>>(v4);
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

