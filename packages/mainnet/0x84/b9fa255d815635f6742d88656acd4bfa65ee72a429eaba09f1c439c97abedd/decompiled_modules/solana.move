module 0x84b9fa255d815635f6742d88656acd4bfa65ee72a429eaba09f1c439c97abedd::solana {
    struct SOLANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/1239bythuxigVXPwfZkUk3Kvm8FS3KfxUsDUpzyPMAGA.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLANA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOLANA  ")))), trim_right(b"OfficialTrumpMelaniaBarron47MAGA"), trim_right(b"Thesis is simple, This meme coin combines OFFICIAL TRUMP, MELANIA MEME, and OFFICIAL BARRON MEME into one powerful token. 47 stands for Donald Trump as the 47th President of the United States, and MAGA means \"Make America Great Again,\" his famous slogan.                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLANA>>(v4);
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

