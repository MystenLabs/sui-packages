module 0x504746efa5ec41a8bf7c26b88685222e869bbaf6692ae385d394cc34711174d7::tester {
    struct TESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTER>(arg0, 6, b"TESTER", b"TEST", b"v", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiduxeqgp4xr7zgmw43oogfm34xgfjc57pkmikekg32abeyhjmqqki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

