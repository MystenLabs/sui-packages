module 0xbe926170a9f4276895788b8e2d50be1280ac57d873cb55b1d0dd03bed3a28807::TESTTT {
    struct TESTTT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTTT>, arg1: 0x2::coin::Coin<TESTTT>) {
        0x2::coin::burn<TESTTT>(arg0, arg1);
    }

    fun init(arg0: TESTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTT>(arg0, 2, b"TEST", b"TESTTT", b"dewdeded", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTTT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTTT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

