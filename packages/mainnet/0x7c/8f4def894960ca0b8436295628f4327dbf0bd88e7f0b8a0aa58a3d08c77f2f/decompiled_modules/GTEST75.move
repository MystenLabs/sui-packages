module 0x7c8f4def894960ca0b8436295628f4327dbf0bd88e7f0b8a0aa58a3d08c77f2f::GTEST75 {
    struct GTEST75 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST75>, arg1: 0x2::coin::Coin<GTEST75>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST75>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST75>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST75>>(0x2::coin::mint<GTEST75>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST75>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST75>>(arg0);
    }

    fun init(arg0: GTEST75, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST75>(arg0, 9, b"GTEST75", b"GradTest75", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/usdc_03b37ed889.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST75>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST75>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

