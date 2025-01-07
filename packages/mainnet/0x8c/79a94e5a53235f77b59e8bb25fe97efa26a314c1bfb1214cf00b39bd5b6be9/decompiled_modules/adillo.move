module 0x8c79a94e5a53235f77b59e8bb25fe97efa26a314c1bfb1214cf00b39bd5b6be9::adillo {
    struct ADILLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADILLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADILLO>(arg0, 9, b"Adillo", b"Adillo on SUI", b"Armadillo means armored, l am endangered species and Ilive in same zoo as moo deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNj24i8J7vbR8gHBbMQ5vTMt3EZhpN4soJzhEyPKbfRkD")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADILLO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADILLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADILLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

