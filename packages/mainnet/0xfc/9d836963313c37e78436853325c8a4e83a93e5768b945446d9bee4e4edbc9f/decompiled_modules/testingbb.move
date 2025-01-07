module 0xfc9d836963313c37e78436853325c8a4e83a93e5768b945446d9bee4e4edbc9f::testingbb {
    struct TESTINGBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTINGBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTINGBB>(arg0, 6, b"TESTINGBB", b"this is only a testing bb", b"this is only a testing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picture1_4de57068ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTINGBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTINGBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

