module 0xb57188842f5f2d7e8e08de5f2b183b2cc15bbbb5582414008cf341fa4ec5d388::GTEST7 {
    struct GTEST7 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST7>, arg1: 0x2::coin::Coin<GTEST7>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST7>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST7>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST7>>(0x2::coin::mint<GTEST7>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST7>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST7>>(arg0);
    }

    fun init(arg0: GTEST7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST7>(arg0, 9, b"GTEST7", b"GradTest7", b"This is only a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

