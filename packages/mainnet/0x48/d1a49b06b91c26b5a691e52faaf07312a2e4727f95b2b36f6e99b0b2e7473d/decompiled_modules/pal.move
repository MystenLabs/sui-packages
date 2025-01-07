module 0x48d1a49b06b91c26b5a691e52faaf07312a2e4727f95b2b36f6e99b0b2e7473d::pal {
    struct PAL has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAL>>(0x2::coin::mint<PAL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/F6s9BkT4c5tAcx3aNNLNYvPpjHHdrUc3mqt1oKV2KkFC.png?size=lg&key=50c3d0                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PAL     ")))), trim_right(b"Pets Are Legends                "), trim_right(b"Lets face it: pets arent just animalstheyre legends. They bring joy, loyalty, and love into our lives, leaving paw prints on our hearts forever.                                                                                                                                                                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAL>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAL>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PAL>>(0x2::coin::mint<PAL>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

