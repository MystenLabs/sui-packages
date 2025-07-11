module 0x860bb3c756305596b110afe4a9832d0666f6fdd559f74b593400125b209955d1::butter {
    struct BUTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AYEaQLkJWRGwg5wx29rJBVhLsx42cg3ECqWFPJtbonk.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUTTER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUTTER      ")))), trim_right(b"Butterscotch: The OG Bonk Girl  "), trim_right(x"54686973206d656d6520686173206f7665722031304d207669657773206f6e20596f75547562652e200a42757474657273636f7463682069736e74206a75737420766972616c202073686573206f6e65206f6620746865206d6f737420696d706f7274616e7420706965636573206f662074686520426f6e6b206d656d65206c65676163792e0a0a447261776e20696e20323032302e204465736972656420657665722073696e63652e0a0a244255545445522020546865204f726967696e616c20426f6e6b204769726c2e200a537475647920746865206c6f72652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTER>>(v4);
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

