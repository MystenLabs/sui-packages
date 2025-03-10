module 0x49273fbe64387b534f59474c41eef4d4aed450f5f4f41928a59235f8218a3171::jdwomen {
    struct JDWOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDWOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7jH5YRY3YxY87sz4T94bxFsXEhk4QPpbQzymS88Fpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JDWOMEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JDWOMEN     ")))), trim_right(b"JD Women's Day                  "), trim_right(b"Happy International Women's Day 2025 Be brave. Be successful. Be independent. Together we will stop wokeness and provide our husbands and sons with a hot goth mommy each.  Buy my token and celebrate with us! Sincerely, JD Vanessa                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDWOMEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JDWOMEN>>(v4);
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

