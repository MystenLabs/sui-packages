module 0x95b54c9d64c4fdb6790cd55b2831c53b4d65b09264285a5abd2e494ccd725e79::jtvo {
    struct JTVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JTVO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9VY2rDbtsBmTsBxoRF8hWSEUKGqnoQoe9V6W3JnjNgfm.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JTVO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JTVO        ")))), trim_right(b"Jatevo                          "), trim_right(x"4a415445564f20284a617461797520566f7274657829202d20446563656e7472616c697a656420414920436c6f756420506c6174666f726d2e20556c7472612d66617374204c4c4d20696e666572656e636520757020746f2035303020746f6b656e2f7365636f6e642077697468206f70656e2d736f75726365206d6f64656c732028446565705365656b2c204c6c616d612034292e200a57652070726f76696465204c4c4d206368617420696e666572656e63652072756e6e696e67206f6e204e564944494120475055732028426c61636b77656c6c2047423230302c2048475820423230302c2048323030292c20534e34304c205265636f6e666967757261626c652044617461666c6f7720556e697420285244552920616e64204365726562726173205753452d33202857616665722d5363616c6520456e67696e6520"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JTVO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JTVO>>(v4);
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

