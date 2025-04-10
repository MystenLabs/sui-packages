module 0x1d6fcae0b476ff4c462aa5a00df13fdca304418121ce144c01f1590838820a00::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FARTCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FARTCOIN>>(0x2::coin::mint<FARTCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9BB6NFEcjBCtnNLFko2FqVQBq8HHM13kCyYcdQbgpump.png?size=lg&key=8180d2                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Fartcoin")))), trim_right(b"Fartcoin on Sui                 "), trim_right(b"Tokenising farts with the help of bots.  No TG, no cabal, fart freely!                                                                                                                                                                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARTCOIN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FARTCOIN>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FARTCOIN>>(0x2::coin::mint<FARTCOIN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

