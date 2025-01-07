module 0x9f056d3368d4d010530845335cb277c0334db03c74c2c933c8e43b01311d3a43::pepnut {
    struct PEPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://pump.mypinata.cloud/ipfs/QmccxiHZ1CzcQyyHXf6aLDjNGuQkoqMWYNeLybDYLMp1fG?img-width=256&img-dpr=2&img-onerror=redirect                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPNUT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPNUT  ")))), trim_right(b"PEPNUT                          "), trim_right(b"PEPNUT (ticker: PEPNUT) $PEPNUT - a new standard token that blends the classic legacy of @pepecoineth with the fresh wave of @pnutsolana culture, coming together to create a bold new future.                                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPNUT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPNUT>>(v4);
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

