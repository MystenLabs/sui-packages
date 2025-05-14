module 0xef7f3cb93ff6d686ba1a659fd3c9fc9a6c6387c3954300c678119337b61faff::obp {
    struct OBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Amn5z1gGKWjVwy5FqmpTSWPcF3RmZL2BQ9vwxJhspump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OBP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OBP         ")))), trim_right(b"Official BLACK PEPE             "), trim_right(b"Introducing Official Black Pepe  the crypto coin thats been through the trenches and is tired of seeing the community get rugged. Black Pepe has seen it all  the scams, the pump-and-dumps, and the broken promises. But now, its back with a vengeance, stronger and more determined than ever before. Official Black Pepe is "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBP>>(v4);
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

