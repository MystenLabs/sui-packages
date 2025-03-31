module 0x732649d812d97dfbbda9ce1205ec6b9043c0e8d61bfdb5cef97b69edb667234b::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9uQKtpuxP4DNoVvfU2MJsjJStDNFaWJVY5ZjZpiRpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CULT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Cult        ")))), trim_right(b"Dip Cult                        "), trim_right(x"496620796f75726520616c7265616479207468696e6b696e67206f66206a656574696e672c2077656c6c2065617420796f7572206675636b696e672064697020616e6420776174636820796f7520464f4d4f206261636b20696e2e0a0a4c6f636b20746865206675636b20696e2e204a6f696e207468652063756c742e0a0a53746f70206265696e6720612070617065722d68616e6465642070757373792e0a0a47726f7720736f6d652062616c6c7320616e64206a6f696e207468652063756c742e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULT>>(v4);
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

