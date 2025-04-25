module 0x45d35f54092ac1a22b6582b1c152fab6fce69e2770f522b5b57a783990f80de9::wtfo {
    struct WTFO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WTFO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WTFO>>(0x2::coin::mint<WTFO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WTFO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8C4RygkxmePm9ys1qCcAB46dUCXNQYTaqfxS5mBrpump.png?size=lg&key=28d918                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WTFO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WTFO    ")))), trim_right(b"WTF Opossum                     "), trim_right(b"WE ARE A CLAN. A NEST OF ALPHA OPOSSUMS. A WTF LEVEL OF ALPHA OPOSSUM. WE DECIDED TO BUILD OUR NEW HOME ON SUI BLOCKCHAIN WHERE WE CAN GROW OUR COMMUNITY TO CONQUER THE CRYPTO SPACE.                                                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTFO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WTFO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<WTFO>>(0x2::coin::mint<WTFO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

