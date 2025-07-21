module 0xe5279f707e757064a0289ead61c1f5231b5b7db03666b7d474a5e554be66084b::testai {
    struct TESTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTAI>(arg0, 6, b"TESTAI", b"Test AI", x"446f6ee280997420627579", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2936_186b7bf959.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

