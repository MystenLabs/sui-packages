module 0x1c586832b28a91b30695e2168bf2b05722692b2eb3fbea8676ab191bd1f41edb::testferra1 {
    struct TESTFERRA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTFERRA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTFERRA1>(arg0, 9, b"TESTFERRA1", b"testferra1", b"Test token for Ferra DAMM launch via ferratest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://placeholder.com/icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTFERRA1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTFERRA1>>(v1);
    }

    // decompiled from Move bytecode v6
}

