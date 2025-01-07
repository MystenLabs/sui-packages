module 0xffcfcafba57118163161464a164accc08e10952cc333dd9c686f59e80993c18c::btcius {
    struct BTCIUS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTCIUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BTCIUS>>(0x2::coin::mint<BTCIUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BTCIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3nDvgesyikUWXFpB9ZgBVXUGPemWyfbUDimymJ89JNAu.png?size=lg&key=5dfd68                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTCIUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTCIUS  ")))), trim_right(b"Bitcoinus Maximus               "), trim_right(b"Bitcoinus Maximus is a revolutionary meme token inspired by the power of BTC as Roman deities. With a golden laurel helmet and imperial spirit, Bitcoinus Maximus combines strength, charm, and community.                                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCIUS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BTCIUS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTCIUS>>(0x2::coin::mint<BTCIUS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

