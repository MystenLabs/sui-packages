module 0x4bc940b5eaa7f0f38b5f70a77d99cd5fb6b745bb5b390381deccf51f029c5f41::GTEST24 {
    struct GTEST24 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST24>, arg1: 0x2::coin::Coin<GTEST24>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST24>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST24>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST24>>(0x2::coin::mint<GTEST24>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST24>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST24>>(arg0);
    }

    fun init(arg0: GTEST24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST24>(arg0, 9, b"GTEST24", b"GradTest24", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bscscan.com/token/images/busdt_32.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST24>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST24>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

