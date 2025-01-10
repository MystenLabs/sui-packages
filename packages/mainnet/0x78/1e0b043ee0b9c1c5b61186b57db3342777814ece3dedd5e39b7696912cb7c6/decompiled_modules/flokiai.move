module 0x781e0b043ee0b9c1c5b61186b57db3342777814ece3dedd5e39b7696912cb7c6::flokiai {
    struct FLOKIAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLOKIAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOKIAI>>(0x2::coin::mint<FLOKIAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLOKIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0xae4c637fb9cb5c151549768a787cca54c044bdca.png?size=lg&key=80bf62                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FLOKIAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FLOKIAI ")))), trim_right(b"FLOKI AI BOT                    "), trim_right(b"Floki AI BOT (FLOKIAI) is a cryptocurrency token that operates on the Sui Blockchain technology (SUI). Our core team brings a wealth of experience and knowledge to this exciting new project, which aims to provide a secure and efficient platform for trading digital assets.                                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKIAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLOKIAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOKIAI>>(0x2::coin::mint<FLOKIAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

