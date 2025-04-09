module 0xb98f58584aa5f3e78cee70e3659d14089e504d6e0ae21b9d9b67f36f6872a6b1::tariff {
    struct TARIFF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TARIFF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TARIFF>>(0x2::coin::mint<TARIFF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TARIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EMCwRmsbNX6JSFJhc7nedCBDC7pRBEoZ56tDodwVpump.png?size=lg&key=6d73b5                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TARIFF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TARIFF  ")))), trim_right(b"Just a Tariff Guy               "), trim_right(b"Tariffs have been the talk around the entire world. Everyone is panicking but were just gonna be some chill guys about it!                                                                                                                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARIFF>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TARIFF>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TARIFF>>(0x2::coin::mint<TARIFF>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

