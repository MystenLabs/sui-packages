module 0x71b9dbd31ae3083a1e6e090e3272fcf650415d8b1c6b983ae562ef1e64abc72e::rblk {
    struct RBLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBLK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Fhj9vrBnJo6PEyPE2vUP6ZXc4Mkrba2r3XXi5hED5HGP.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RBLK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RBLK        ")))), trim_right(b"Rollblock                       "), trim_right(x"526f6c6c626c6f636b2069732064697372757074696e67207468652024343530626e2067616d626c696e6720696e647573747279207468726f756768206974732041492064726976656e2047616d626c6546692065636f73797374656d2e0a0a526f6c6c626c6f636b2070726f76696465732075736572732077697468206120686f7374206f66206f6e6c696e652053706f727473626f6f6b2c20436173696e6f2026205669727475616c2067616d696e672073657276696365733b2061636365737369626c6520766961204465736b746f702c206d6f62696c65206f72207461626c65742e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBLK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RBLK>>(v4);
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

