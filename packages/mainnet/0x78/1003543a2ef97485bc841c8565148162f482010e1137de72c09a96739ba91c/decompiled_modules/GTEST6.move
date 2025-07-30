module 0x781003543a2ef97485bc841c8565148162f482010e1137de72c09a96739ba91c::GTEST6 {
    struct GTEST6 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST6>, arg1: 0x2::coin::Coin<GTEST6>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST6>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST6>>(0x2::coin::mint<GTEST6>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST6>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST6>>(arg0);
    }

    fun init(arg0: GTEST6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST6>(arg0, 9, b"GTEST6", b"GradTest6", b"This is only a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST6>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

