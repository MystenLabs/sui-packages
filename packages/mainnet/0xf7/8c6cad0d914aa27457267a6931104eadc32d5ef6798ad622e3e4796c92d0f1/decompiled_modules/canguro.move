module 0xf78c6cad0d914aa27457267a6931104eadc32d5ef6798ad622e3e4796c92d0f1::canguro {
    struct CANGURO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CANGURO>, arg1: 0x2::coin::Coin<CANGURO>) {
        0x2::coin::burn<CANGURO>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<CANGURO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CANGURO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CANGURO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://coin-images.coingecko.com/coins/images/52792/large/canguro_200x200.jpg?1734293532                                                                                                                                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CANGURO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Canguro   ")))), trim_right(b"Team Canguro                    "), trim_right(b"Team Canguro is the most viral and fastest-growing PFP movement on the planet, rapidly taking over TikTok and other social media worldwide.\\r\\n\\r\\nThe origins of Team Canguro trace back to Spanish-speaking TikTok users who popularized the trend as a way to build community and mutual support                             "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANGURO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CANGURO>>(v5);
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

