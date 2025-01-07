module 0x5a00a3380ed4c1397d0e023e41425825a4d12837110193b49ad1b7699adf5b4e::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 2, b"MN", b"Moon", b"my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cetus.zone/coin-metadata/mainnet/icon/3c86d496-1c05-440b-ab0f-fc7642fe9805.jpeg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::coin::mint_and_transfer<MOON>(&mut v2, 100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

