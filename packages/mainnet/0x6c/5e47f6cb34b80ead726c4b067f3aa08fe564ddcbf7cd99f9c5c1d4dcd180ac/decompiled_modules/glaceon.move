module 0x6c5e47f6cb34b80ead726c4b067f3aa08fe564ddcbf7cd99f9c5c1d4dcd180ac::glaceon {
    struct GLACEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLACEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLACEON>(arg0, 6, b"GLACEON", b"GLACEON SUI", b"Glaceon can control its body temperature freely. This Pokemon freezes atmospheric liquid and creates Diamond Dust.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmecva74ifsl6df7a3rwp2324vfn45rhoa77raibak4n6xzdgury")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLACEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLACEON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

