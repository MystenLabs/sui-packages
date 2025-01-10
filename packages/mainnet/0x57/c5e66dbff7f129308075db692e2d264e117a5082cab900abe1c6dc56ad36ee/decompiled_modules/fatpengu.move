module 0x57c5e66dbff7f129308075db692e2d264e117a5082cab900abe1c6dc56ad36ee::fatpengu {
    struct FATPENGU has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FATPENGU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FATPENGU>>(0x2::coin::mint<FATPENGU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FATPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7na9JB1kjRbtiJFN1Nwhp24uyaz4A5BGReRevmJjpump.png?size=lg&key=734bf2                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FATPENGU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FATPENGU")))), trim_right(b"Fat Pengu                       "), trim_right(b"If Pengu can become the biggest memecoin on Sui, imagine the chaos when Pengu turns FAT! $FATPENGU is here to take over!                                                                                                                                                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATPENGU>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FATPENGU>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FATPENGU>>(0x2::coin::mint<FATPENGU>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

