module 0x4ce407bfb655e3148290e78c4bf3871a38c8686661a9691929875829718167a9::TESTIFY {
    struct TESTIFY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTIFY>, arg1: 0x2::coin::Coin<TESTIFY>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TESTIFY>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTIFY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTIFY>>(0x2::coin::mint<TESTIFY>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTIFY>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTIFY>>(arg0);
    }

    fun init(arg0: TESTIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTIFY>(arg0, 9, b"TESTIFY", b"TEST FINAL", b"Testing coin creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:3000/lotus_logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTIFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTIFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

