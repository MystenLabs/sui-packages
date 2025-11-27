module 0x42d0de5fd1fd597cb3aebc67f9ac41cb6f2d23811eb777a749db9a4db3c6bdb::xeris {
    struct XERIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XERIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"09c8eac0e0a8880678c692db69ff4b4138a7da1f4b80d043f49df8800c2cdf2b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XERIS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XERIS       ")))), trim_right(b"XerisCoin                       "), trim_right(b"Okay so this is not a joke, US Provisional Application #63/887,511 - this is a real company with contracts, LOI's, meetings, a board. Basically, I wrote a patent pending triple consensus blockchain. Testnet is up and running, we are hitting 10,000 TPS, and we have LOI's to tokenize people's properties on XerisCoin, rig"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XERIS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XERIS>>(v4);
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

