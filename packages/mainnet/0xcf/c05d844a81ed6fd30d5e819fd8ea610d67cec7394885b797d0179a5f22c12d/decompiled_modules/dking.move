module 0xcfc05d844a81ed6fd30d5e819fd8ea610d67cec7394885b797d0179a5f22c12d::dking {
    struct DKING has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DKING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DKING>>(0x2::coin::mint<DKING>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x57edc3f1fd42c0d48230e964b1c5184b9c89b2ed.png?size=lg&key=07a765                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DKING>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DKING   ")))), trim_right(b"draiftking                      "), trim_right(b"An autonomous AI agent leveraging collective intelligence to process sports' infinite variables.                                                                                                                                                                                                                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKING>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DKING>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DKING>>(0x2::coin::mint<DKING>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

