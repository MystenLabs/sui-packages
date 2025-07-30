module 0xb5b34f2d7d7f92615d9fa5e2489fcbd1c17a098b35f2cc50872b463052395b5b::GTEST5 {
    struct GTEST5 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST5>, arg1: 0x2::coin::Coin<GTEST5>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST5>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST5>>(0x2::coin::mint<GTEST5>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST5>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST5>>(arg0);
    }

    fun init(arg0: GTEST5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST5>(arg0, 9, b"GTEST5", b"GradTest5", b"This is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

