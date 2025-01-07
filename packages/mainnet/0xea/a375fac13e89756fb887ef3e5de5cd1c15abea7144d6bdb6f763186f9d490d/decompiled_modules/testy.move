module 0xeaa375fac13e89756fb887ef3e5de5cd1c15abea7144d6bdb6f763186f9d490d::testy {
    struct TESTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTY>(arg0, 9, b"Testy", b"test 4", b"23452444", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/56a560e3b6fa7daf8cb26cdfce5723b5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

