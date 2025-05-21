module 0x83fcaf18fb6b053dfdbdaf1f5535ba2faa701541e1b3f10c6edd799c8db677b4::coin_one {
    struct COIN_ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_ONE>(arg0, 9, b"coinone", b"coin one", b"coin one desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9900/kappa/coins/012d28dc-087e-43e2-a20c-ea426688f9dc.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

