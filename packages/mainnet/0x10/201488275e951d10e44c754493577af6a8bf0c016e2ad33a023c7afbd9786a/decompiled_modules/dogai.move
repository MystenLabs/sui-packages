module 0x10201488275e951d10e44c754493577af6a8bf0c016e2ad33a023c7afbd9786a::dogai {
    struct DOGAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGAI>>(0x2::coin::mint<DOGAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6x7cEbqp2GWLCW94vsnUYjUbTmqY5RKwxH6Gaa7juCam.png?size=lg&key=29af52                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGAI   ")))), trim_right(b"DOGEAI TERMINAL                 "), trim_right(b"Meet DOGEAI TERMINAL, the perfect blend of meme magic and futuristic AI! Born from the beloved Doge and supercharged with cutting-edge AI, this coin is all about bringing fun and innovation to the Sui blockchain.                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGAI>>(0x2::coin::mint<DOGAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

