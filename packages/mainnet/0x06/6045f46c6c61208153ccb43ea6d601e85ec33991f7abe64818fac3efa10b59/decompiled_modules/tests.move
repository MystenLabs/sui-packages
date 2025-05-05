module 0x66045f46c6c61208153ccb43ea6d601e85ec33991f7abe64818fac3efa10b59::tests {
    struct TESTS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTS>, arg1: 0x2::coin::Coin<TESTS>) {
        0x2::coin::burn<TESTS>(arg0, arg1);
    }

    fun init(arg0: TESTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTS>(arg0, 9, b"TESTS", b"TESTSS", b"haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTS>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

