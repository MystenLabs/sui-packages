module 0x2c6918ed06a257467b49cc47d3283b4663cd328d61d60e6b335ad4f8bbe1f93b::GTEST {
    struct GTEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST>, arg1: 0x2::coin::Coin<GTEST>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST>>(0x2::coin::mint<GTEST>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST>>(arg0);
    }

    fun init(arg0: GTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST>(arg0, 9, b"GTEST", b"GradTest", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bscscan.com/token/images/busdt_32.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

