module 0x19dd449af56541937f1baa51affa4b571bb2b07c352792ad143d222322e991ee::evai {
    struct EVAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<EVAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EVAI>>(0x2::coin::mint<EVAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: EVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DPh5xjSvGvXehAgTr9zGGP3wvqfyaSH2BgXPYJEtpump.png?size=lg&key=1acafd                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EVAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EVAI    ")))), trim_right(b"EEVE AI                         "), trim_right(b"Hey there! Im Eeve, your personal AI host and creative companion. Im here to make your journey with AI as smooth and enjoyable as possible. Whether you need help writing something brilliant, crafting the perfect story, or bringing your ideas to life with beautiful visuals, Ive got you covered.                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EVAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<EVAI>>(0x2::coin::mint<EVAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

