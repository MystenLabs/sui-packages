module 0x548ca90eeb994ad27e3be1a5b51387f7c3a5d4d2e8444705251cafb916fd1ea9::tensie_coin {
    struct TENSIE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TENSIE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TENSIE_COIN>>(0x2::coin::mint<TENSIE_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TENSIE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENSIE_COIN>(arg0, 9, b"TNSIE", b"TENSIE", b"TENSIE token on the Sui network", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TENSIE_COIN>>(0x2::coin::mint<TENSIE_COIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TENSIE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENSIE_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

