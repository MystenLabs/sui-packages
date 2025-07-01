module 0x58761abf1f677e6828d01067c962ee09b0710481cdee2f6715851429e7078f83::TESTCOIN {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: 0x2::coin::Coin<TESTCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TESTCOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(0x2::coin::mint<TESTCOIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTCOIN>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTCOIN>>(arg0);
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 9, b"TESTCOIN", b"Test Coin", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_686467bbb59db0.76052944.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

