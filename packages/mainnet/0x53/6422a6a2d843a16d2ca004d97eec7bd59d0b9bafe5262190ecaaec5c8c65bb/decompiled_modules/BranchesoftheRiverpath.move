module 0x536422a6a2d843a16d2ca004d97eec7bd59d0b9bafe5262190ecaaec5c8c65bb::BranchesoftheRiverpath {
    struct BRANCHESOFTHERIVERPATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRANCHESOFTHERIVERPATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRANCHESOFTHERIVERPATH>(arg0, 0, b"COS", b"Branches of the Riverpath", b"The woods will unravel when the time is right... when you truly arrive...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Branches_of_the_Riverpath.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRANCHESOFTHERIVERPATH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRANCHESOFTHERIVERPATH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

