module 0x3cdc6fe1ae053798e348f5d6110cdcf9981be46db2c099107851c69304be69df::TESTCOINB {
    struct TESTCOINB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTCOINB>, arg1: 0x2::coin::Coin<TESTCOINB>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TESTCOINB>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOINB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOINB>>(0x2::coin::mint<TESTCOINB>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTCOINB>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTCOINB>>(arg0);
    }

    fun init(arg0: TESTCOINB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOINB>(arg0, 9, b"TESTCOINB", b"Test B", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bscscan.com/token/images/busdt_32.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOINB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOINB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

