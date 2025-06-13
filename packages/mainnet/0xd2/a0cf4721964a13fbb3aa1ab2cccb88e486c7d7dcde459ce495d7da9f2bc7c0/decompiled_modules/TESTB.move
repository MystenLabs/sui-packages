module 0xd2a0cf4721964a13fbb3aa1ab2cccb88e486c7d7dcde459ce495d7da9f2bc7c0::TESTB {
    struct TESTB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTB>, arg1: 0x2::coin::Coin<TESTB>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TESTB>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTB>>(0x2::coin::mint<TESTB>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTB>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTB>>(arg0);
    }

    fun init(arg0: TESTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTB>(arg0, 9, b"TESTB", b"Test B", b"This is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_684c7032d8f2a6.05892952.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

