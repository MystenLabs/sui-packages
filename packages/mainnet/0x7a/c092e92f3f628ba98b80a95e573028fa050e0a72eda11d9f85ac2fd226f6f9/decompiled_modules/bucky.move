module 0x7ac092e92f3f628ba98b80a95e573028fa050e0a72eda11d9f85ac2fd226f6f9::bucky {
    struct BUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/29ZVug6YChW6cjv8Ftp9feoCVA5HdE8RUWDxxgrPpump.png?claimId=4L477AZ5Uxc-xxO6                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUCKY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Bucky       ")))), trim_right(b"Bucky the overthinking deer     "), trim_right(x"6275636b7920746865206f7665727468696e6b696e6720646565722068616420647265616d73206f66206c616d626f7320616e642072617269730a2020202020202020202020202020202062757420616c7761797320726f746174656420696e746f207275677320617065200a202020202020202020202020202020246275636b79206e6f7720646f6e74206f7665727468696e6b206974202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKY>>(v4);
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

