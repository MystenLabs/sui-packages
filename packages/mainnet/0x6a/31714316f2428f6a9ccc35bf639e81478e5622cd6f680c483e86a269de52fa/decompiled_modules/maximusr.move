module 0x6a31714316f2428f6a9ccc35bf639e81478e5622cd6f680c483e86a269de52fa::maximusr {
    struct MAXIMUSR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAXIMUSR>, arg1: 0x2::coin::Coin<MAXIMUSR>) {
        0x2::coin::burn<MAXIMUSR>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<MAXIMUSR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MAXIMUSR>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MAXIMUSR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3teLjPrDTFeAP88S5JGCYnXBY6TENu1aVw7kHxm9GACE.png?size=lg&key=c81086                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAXIMUSR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MaximusR  ")))), trim_right(b"MAXIMUS RESOLUTIONUS            "), trim_right(b"MaximusResolutionus is a witty and legendary Kekius Maximus figure, symbolizing humanitys timeless battle with New Years resolutions.                                                                                                                                                                                           "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAXIMUSR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAXIMUSR>>(v5);
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

