module 0x4d7737241960607c77cb31830a89920eb2bb6be9f11c2228b33f0a97736e5e46::icm {
    struct ICM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"083b6816ad9f9e810c455a18fdc3c1b2b20eb09169ee297dcce01cb9c678caa4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ICM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ICM         ")))), trim_right(b"Internet Capital Memes          "), trim_right(b"Internet Capital Memes (ICM) is a community-driven meme token on the Solana blockchain that celebrates and strengthens the cultural identity of Solana as the Capital of Memes. Its purpose is to transform internet humor into structured on-chain participation by rewarding creators, traders, and communities for their cont"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICM>>(v4);
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

