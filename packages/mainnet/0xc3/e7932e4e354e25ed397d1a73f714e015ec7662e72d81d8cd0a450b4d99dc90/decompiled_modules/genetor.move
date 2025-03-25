module 0xc3e7932e4e354e25ed397d1a73f714e015ec7662e72d81d8cd0a450b4d99dc90::genetor {
    struct GENETOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENETOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreifinymio4b43w6u6pfruvkpzzr24h7kksfrfurkyrvafs7mwuup7m                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<GENETOR>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GENETOR ")))), trim_right(b"GENERATOR                       "), trim_right(b"AI AND ML                                                                                                                                                                                                                                                                                                                       "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<GENETOR>>(0x2::coin::mint<GENETOR>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GENETOR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENETOR>>(v3);
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

