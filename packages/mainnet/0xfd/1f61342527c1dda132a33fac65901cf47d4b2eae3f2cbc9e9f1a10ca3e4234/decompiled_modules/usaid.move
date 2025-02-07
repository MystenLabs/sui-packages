module 0xfd1f61342527c1dda132a33fac65901cf47d4b2eae3f2cbc9e9f1a10ca3e4234::usaid {
    struct USAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: USAID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6P8ixuqGZpfyHAxyxbU4a31vsMiFiCQjBzVV58gPpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<USAID>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"USAID       ")))), trim_right(b"USAID                           "), trim_right(x"4561726c79204d6f6e6461792c200a456c6f6e204d75736b20282040656c6f6e6d75736b20292068656c642061206c6976652073657373696f6e206f6e2058205370616365732c2070726576696f75736c79206b6e6f776e2061732054776974746572205370616365732c20616e64207361696420746861742068652073706f6b6520696e2064657461696c2061626f757420555341494420776974682074686520707265736964656e742e204865206167726565642077652073686f756c64207368757420697420646f776e2c204d75736b20736169642e0a0a497420626563616d65206170706172656e74207468617420697473206e6f7420616e206170706c652077697468206120776f726d20697420696e2c204d75736b20736169642e20576861742077652068617665206973206a75737420612062616c6c206f66"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USAID>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USAID>>(v4);
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

