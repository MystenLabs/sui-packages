module 0xbfae1cf7c0c06afe533f866dabbec5323ad2d89b4e45c43d13c812c4687ca716::keria {
    struct KERIA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KERIA>, arg1: 0x2::coin::Coin<KERIA>) {
        0x2::coin::burn<KERIA>(arg0, arg1);
    }

    fun init(arg0: KERIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KERIA>(arg0, 9, b"KERIA", b"Keria", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KERIA>>(v2);
        let v4 = &mut v3;
        mint(v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERIA>>(v3, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<KERIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KERIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

