module 0x2e323db3722609d1ed4a42433953312d5b06214195a0634e692a44af6713d6d3::zewensky {
    struct ZEWENSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEWENSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/E3YJWtJh5ckAvJqJzuyEmzyH9UAs7dSL8vPuACmYpump.png?claimId=2JLpA6wspCe4d_Cy                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZEWENSKY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZEWENSKY    ")))), trim_right(b"Zewensky                        "), trim_right(b"In the world of political memes, one name stands outZewensky (ZEWENSKY), the king of aid requests, media stunts, and endless funding rounds! Whether it's begging, performing, or just vibing, this token captures the true essence of the meme economy.                                                                        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEWENSKY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEWENSKY>>(v4);
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

