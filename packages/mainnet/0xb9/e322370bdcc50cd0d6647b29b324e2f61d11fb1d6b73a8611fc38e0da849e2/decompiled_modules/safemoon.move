module 0xb9e322370bdcc50cd0d6647b29b324e2f61d11fb1d6b73a8611fc38e0da849e2::safemoon {
    struct SAFEMOON has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAFEMOON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAFEMOON>>(0x2::coin::mint<SAFEMOON>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAFEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2kGfWRgNp1QaxUMFCX9CMN78E1iCbgjBAZuQNUjWpump.png?size=lg&key=6802c2                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SAFEMOON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SAFEMOON")))), trim_right(b"SafeMoon                        "), trim_right(b"I was sent 50% of the supply for the Sui safemoon as a meme. I burned 10% of the token supply. I put 39% into the token liquidity. I sent 1% out to get some KOLs involved.                                                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFEMOON>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAFEMOON>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAFEMOON>>(0x2::coin::mint<SAFEMOON>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

