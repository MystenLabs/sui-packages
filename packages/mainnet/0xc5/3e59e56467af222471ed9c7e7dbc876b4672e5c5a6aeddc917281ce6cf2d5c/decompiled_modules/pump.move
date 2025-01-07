module 0xc53e59e56467af222471ed9c7e7dbc876b4672e5c5a6aeddc917281ce6cf2d5c::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: 0x2::coin::Coin<PUMP>) {
        0x2::coin::burn<PUMP>(arg0, arg1);
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"PUMP", b"let's pump it to the moon", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

