module 0x3066fc4c1bd0c4937a2f87721109ec38b83d82468fac3f2e493058fd6cda7d85::btst {
    struct BTST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTST>(arg0, 6, b"BTST", b"bundletest", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/null"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTST>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BTST>>(v2);
    }

    // decompiled from Move bytecode v6
}

