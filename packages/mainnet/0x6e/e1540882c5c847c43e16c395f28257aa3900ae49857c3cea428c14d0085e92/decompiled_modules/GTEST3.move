module 0x6ee1540882c5c847c43e16c395f28257aa3900ae49857c3cea428c14d0085e92::GTEST3 {
    struct GTEST3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GTEST3>, arg1: 0x2::coin::Coin<GTEST3>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GTEST3>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GTEST3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GTEST3>>(0x2::coin::mint<GTEST3>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<GTEST3>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GTEST3>>(arg0);
    }

    fun init(arg0: GTEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTEST3>(arg0, 9, b"GTEST3", b"GradTest3", b"This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTEST3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTEST3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

