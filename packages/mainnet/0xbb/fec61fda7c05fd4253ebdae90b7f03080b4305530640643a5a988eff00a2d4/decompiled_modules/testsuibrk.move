module 0xbbfec61fda7c05fd4253ebdae90b7f03080b4305530640643a5a988eff00a2d4::testsuibrk {
    struct TESTSUIBRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSUIBRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTSUIBRK>(arg0, 6, b"TESTSUIBRK", b"testSUIBRKR", b"testSUIBR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTSUIBRK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSUIBRK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

