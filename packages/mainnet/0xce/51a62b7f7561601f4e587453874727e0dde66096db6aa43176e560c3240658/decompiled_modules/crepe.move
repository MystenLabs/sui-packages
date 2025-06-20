module 0xce51a62b7f7561601f4e587453874727e0dde66096db6aa43176e560c3240658::crepe {
    struct CREPE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CREPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CREPE>>(0x2::coin::mint<CREPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CREPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0xeb2b7d5691878627eff20492ca7c9a71228d931d.png?size=lg&key=76fdfd                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CREPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CREPE   ")))), trim_right(b"CREPE                           "), trim_right(b"Feel the power of decentralization. Copytrading - Swap - Liquid Pools. Anything related to DeFi. $CREPE is also meme                                                                                                                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREPE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CREPE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CREPE>>(0x2::coin::mint<CREPE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

