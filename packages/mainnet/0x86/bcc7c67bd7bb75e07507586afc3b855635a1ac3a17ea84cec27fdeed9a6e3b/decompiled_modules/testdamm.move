module 0x86bcc7c67bd7bb75e07507586afc3b855635a1ac3a17ea84cec27fdeed9a6e3b::testdamm {
    struct TESTDAMM has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTDAMM>, arg1: 0x2::coin::Coin<TESTDAMM>) {
        0x2::coin::burn<TESTDAMM>(arg0, arg1);
    }

    fun init(arg0: TESTDAMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTDAMM>(arg0, 6, b"TDAMM", b"TestDamm", b"Test token from DAMM DBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTDAMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTDAMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTDAMM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTDAMM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

