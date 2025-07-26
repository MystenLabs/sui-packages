module 0x6c435400538e7dfc05ca3c399d98be6da17f594b25563e2f08c308b8046ffeb0::GTEST2 {
    struct GTEST2 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST2>, arg1: 0x2::coin::Coin<GTEST2>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST2>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST2>>(0x2::coin::mint<GTEST2>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST2>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST2>>(arg0);
    }

    fun init(arg0: GTEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST2>(arg0, 9, b"GTEST2", b"GradTest2", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

