module 0xf81abe2c2fa9964daa3c6d737cf98a037bcead67ba030ed733b7ce993a9315d8::GTEST4 {
    struct GTEST4 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST4>, arg1: 0x2::coin::Coin<GTEST4>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST4>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST4>>(0x2::coin::mint<GTEST4>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST4>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST4>>(arg0);
    }

    fun init(arg0: GTEST4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST4>(arg0, 9, b"GTEST4", b"GradTest4", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST4>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

