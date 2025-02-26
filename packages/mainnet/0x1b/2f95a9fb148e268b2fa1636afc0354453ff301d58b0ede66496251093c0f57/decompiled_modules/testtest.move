module 0x1b2f95a9fb148e268b2fa1636afc0354453ff301d58b0ede66496251093c0f57::testtest {
    struct TESTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTEST>(arg0, 9, b"testtest", b"testtest", b"testtest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"testtest")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTTEST>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTTEST>>(v2);
    }

    // decompiled from Move bytecode v6
}

