module 0xe82035e51bc3db37abb2a1b40983813626d80d85bcc57ee3fef595b4cc30a3e8::TESTCOINC {
    struct TESTCOINC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTCOINC>, arg1: 0x2::coin::Coin<TESTCOINC>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TESTCOINC>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOINC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOINC>>(0x2::coin::mint<TESTCOINC>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTCOINC>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTCOINC>>(arg0);
    }

    fun init(arg0: TESTCOINC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOINC>(arg0, 9, b"TESTCOINC", b"Test C", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/usdt.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOINC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOINC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

