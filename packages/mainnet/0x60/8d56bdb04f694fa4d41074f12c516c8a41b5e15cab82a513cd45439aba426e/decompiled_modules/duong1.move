module 0x608d56bdb04f694fa4d41074f12c516c8a41b5e15cab82a513cd45439aba426e::duong1 {
    struct DUONG1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUONG1>, arg1: 0x2::coin::Coin<DUONG1>) {
        0x2::coin::burn<DUONG1>(arg0, arg1);
    }

    fun init(arg0: DUONG1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUONG1>(arg0, 9, b"DUONG1", b"Duong1 Token", b"This is a dummy token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUONG1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUONG1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUONG1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUONG1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

