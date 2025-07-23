module 0x8b7550218a5ba1f45f76bf4079a3446ea13ef2d96e0159d868778f18972363d4::testtt {
    struct TESTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 832 || 0x2::tx_context::epoch(arg1) == 833, 1);
        let (v0, v1) = 0x2::coin::create_currency<TESTTT>(arg0, 9, b"testtt", b"testtt", b"testtttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmYJNVRaJYbkSfa58nZ5dWJAiAiqJoofDARMHCcUc9NNJ2"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTTT>(&mut v2, 1000000000000000000, @0x7bd2c17cac4fcecc6df984456eada34a3f296ecf6eb78f992cd458dfc6c10776, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTT>>(v2, @0x7bd2c17cac4fcecc6df984456eada34a3f296ecf6eb78f992cd458dfc6c10776);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

