module 0x446f9205e3562ea53679ba2fd8f4f799626b1b7d381cc51b2517402e0f3ac0ac::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOBO>>(0x2::coin::mint<BOBO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xb90b2a35c65dbc466b04240097ca756ad2005295.png?size=lg&key=13f490                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOBO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOBO    ")))), trim_right(b"BOBO                            "), trim_right(b"Bobo the Bear is a meme character that has become a symbol of satirical wisdom and collective pessimism in financial markets, especially during downturns. Bobo is associated with bear markets and is often shared alongside other popular internet memes like Apu Apustaja and Pepe the Frog.                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOBO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOBO>>(0x2::coin::mint<BOBO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

