module 0x4b3f3c623f00abfaa843eef715ba0defbb739c8953a52821488c2ca0ac8afcb::minhtest {
    struct MINHTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINHTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINHTEST>(arg0, 9, b"minhtest", b"minhtest", b"minhtest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"minhtest")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINHTEST>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINHTEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINHTEST>>(v2);
    }

    // decompiled from Move bytecode v6
}

