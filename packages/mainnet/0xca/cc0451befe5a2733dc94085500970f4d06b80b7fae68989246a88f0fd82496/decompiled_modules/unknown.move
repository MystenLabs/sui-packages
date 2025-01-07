module 0xcacc0451befe5a2733dc94085500970f4d06b80b7fae68989246a88f0fd82496::unknown {
    struct UNKNOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNKNOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNKNOWN>(arg0, 6, b"Unknown", b"Unknown on sui", b"unknown", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956031823.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNKNOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNKNOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

