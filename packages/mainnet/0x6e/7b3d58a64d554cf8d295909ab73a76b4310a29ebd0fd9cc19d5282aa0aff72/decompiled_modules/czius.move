module 0x6e7b3d58a64d554cf8d295909ab73a76b4310a29ebd0fd9cc19d5282aa0aff72::czius {
    struct CZIUS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CZIUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CZIUS>>(0x2::coin::mint<CZIUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CZIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x43fed8f6cc2b15ef21bc4d04d50f2819c161eed7.png?size=lg&key=64c75a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CZIUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CZius   ")))), trim_right(b"CZius Maximus                   "), trim_right(b"CZius Maximus: The Golden Emperor of Meme. Czius Maximus, the radiant golden of Binance, reigns supreme as the sovereign ruler of the mythical Aquaticus Memelantis, a glittering underwater realm where memes ripple like waves and laughter flows as freely as the tides.                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZIUS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CZIUS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CZIUS>>(0x2::coin::mint<CZIUS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

