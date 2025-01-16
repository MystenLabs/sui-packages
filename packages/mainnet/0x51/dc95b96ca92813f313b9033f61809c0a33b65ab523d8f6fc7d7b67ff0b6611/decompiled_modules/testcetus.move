module 0x51dc95b96ca92813f313b9033f61809c0a33b65ab523d8f6fc7d7b67ff0b6611::testcetus {
    struct TESTCETUS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTCETUS>, arg1: 0x2::coin::Coin<TESTCETUS>) {
        0x2::coin::burn<TESTCETUS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCETUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCETUS>>(0x2::coin::mint<TESTCETUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TESTCETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCETUS>(arg0, 9, b"testCetus", b"TESTCETUS", b"tester", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"example.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

