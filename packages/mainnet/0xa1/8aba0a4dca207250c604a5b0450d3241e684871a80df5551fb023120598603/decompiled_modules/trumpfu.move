module 0xa18aba0a4dca207250c604a5b0450d3241e684871a80df5551fb023120598603::trumpfu {
    struct TRUMPFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPFU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6HaiSF7HSM2AJqcAEeVXV22fi3f3fj4qaiPFfdJipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUMPFU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRUMPFU ")))), trim_right(b"TRUMPWAIFU                      "), trim_right(b"Introducing TRUMPWAIFU, the meme coin that combines your love for waifus with a playful twist of Trump admiration. With this unique cryptocurrency, you can pick your favorite waifu inspired by the iconic personality of Trump. Each Trump waifu has her own characteristics and charm, bringing fun and excitement to the wor"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPFU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPFU>>(v4);
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

