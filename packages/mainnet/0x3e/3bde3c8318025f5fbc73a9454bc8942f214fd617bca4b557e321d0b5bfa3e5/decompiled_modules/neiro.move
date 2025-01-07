module 0x3e3bde3c8318025f5fbc73a9454bc8942f214fd617bca4b557e321d0b5bfa3e5::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x812ba41e071c7b7fa4ebcfb62df5f45f6fa853ee.png?size=lg&key=bed754                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEIRO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEIRO   ")))), trim_right(b"Neiro                           "), trim_right(b"Neiro is like the little sister to Doge and the heir to her legacy. Adopted by the same woman that once owned Kabosu (the dog behind the Doge meme), Neiro carries forward the true spirit of memecoins and internet culture. Our Neiro was the first to deploy on SUI, the precise moment of the New Moon.                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v4);
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

