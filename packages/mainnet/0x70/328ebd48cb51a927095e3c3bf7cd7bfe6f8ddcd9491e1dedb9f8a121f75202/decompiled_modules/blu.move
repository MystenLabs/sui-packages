module 0x70328ebd48cb51a927095e3c3bf7cd7bfe6f8ddcd9491e1dedb9f8a121f75202::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 6, b"BLU", b"BLU SUI", b"Join the heavens of decentralized glory with $BLU!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih5rffyfplvcnvir3x6acfkg5ww2rmfnboz2pkdt2us5rtbs5posa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

