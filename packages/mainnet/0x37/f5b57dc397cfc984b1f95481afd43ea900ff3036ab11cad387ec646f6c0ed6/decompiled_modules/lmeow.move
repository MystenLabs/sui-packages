module 0x37f5b57dc397cfc984b1f95481afd43ea900ff3036ab11cad387ec646f6c0ed6::lmeow {
    struct LMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9KMk8Gfm5hX86rhGKMqVWCmud2yJTMaExr84ZN5PrwFV.png?claimId=5051412d7623                                                                                                                                                                                                          ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LMEOW>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LMEOW       ")))), trim_right(b"lmeow                           "), trim_right(x"436174616c797a696e67206120706172616469676d20736869667420696e206d656d6520696e76657374696e6720617761792066726f6d20646f6720746f6b656e7320746f2063617420746f6b656e732e0a0a546865207573616765206f6620226c6d656f77222069732067726f77696e672065766572796461792e2052656d656d62657220757320746865206e6578742074696d6520796f7520686561722069742e0a0a4a6f696e207468652063756c742e0a0a46756c66696c6c207468652070726f70686563792e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMEOW>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMEOW>>(v4);
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

