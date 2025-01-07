module 0xeef96fd845a994406569ffcbeb272f2ae7a34c63dde09716f5af4298b796d9ac::clap {
    struct CLAP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CLAP>>(0x2::coin::mint<CLAP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9b8jL2wcVjBFpieC5TUR76BDJ6sW8Eghd3fyq5VJmzir.png?size=lg&key=c646ca                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CLAP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CLAP    ")))), trim_right(b"Clap Cat                        "), trim_right(b"Clap Cat is the official cat sister to Pop Cat also known as Eleanor owned by the infamous discord user known only as XavierBFB on X and discord made world famous from the Pop Cat memes.                                                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAP>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CLAP>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CLAP>>(0x2::coin::mint<CLAP>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

