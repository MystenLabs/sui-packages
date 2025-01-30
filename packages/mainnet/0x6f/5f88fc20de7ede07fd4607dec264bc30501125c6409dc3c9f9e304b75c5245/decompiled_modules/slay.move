module 0x6f5f88fc20de7ede07fd4607dec264bc30501125c6409dc3c9f9e304b75c5245::slay {
    struct SLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafybeibtzvnev2usngkg7i34qdohnfekgzddatxhljh6hdxoitk5lsnrt4                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<SLAY>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SLAY    ")))), trim_right(b"SLAY Token                      "), trim_right(b"Powers microtrend predictions and clean girl economy challenges                                                                                                                                                                                                                                                                 "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<SLAY>>(0x2::coin::mint<SLAY>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SLAY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLAY>>(v3);
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

