module 0xea7f1b97daa9288d311e60e6befb4ae1d7671f1e0381d0f2ebf9db42e3aac28e::testtt {
    struct TESTTT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTTT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTTT>>(0x2::coin::mint<TESTTT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TESTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTT>(arg0, 6, b"TESTTT", b"TESTTT", b"This is TESTTT token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

