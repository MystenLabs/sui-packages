module 0x3bb9df4da116fc108cdce49c5feb47fad557b2535e6087faaf7d0ae378e20c9e::miguels {
    struct MIGUELS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIGUELS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MIGUELS>>(0x2::coin::mint<MIGUELS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MIGUELS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x5cc96c50350361c23ad732f7f509f7e0bca41487.png?size=lg&key=524d1c                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MIGUELS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Miguels ")))), trim_right(b"MR.Miguels                      "), trim_right(b"Mr. Miguels is the spicy, sombrero-wearing cousin of the popular meme coin, Mr. Miggles. Hailing from the heart of the blockchain, Mr. Miguels is all about fun, fiestas, and fiery tokenomics.                                                                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGUELS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIGUELS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MIGUELS>>(0x2::coin::mint<MIGUELS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

