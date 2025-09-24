module 0xaffd1fa8488e47ba785f654fd210d819eac61c7343d002409160973598005608::siubotai {
    struct SIUBOTAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIUBOTAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIUBOTAI>>(0x2::coin::mint<SIUBOTAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SIUBOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUBOTAI>(arg0, 9, b"SiuBotAi", b"SIUBOTAI", b"AI on SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SIUBOTAI>>(0x2::coin::mint<SIUBOTAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUBOTAI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIUBOTAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

