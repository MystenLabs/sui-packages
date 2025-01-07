module 0xe608503eba1a3136b33121cebd108158219b0f06e923df329d00c20146749206::orcie {
    struct ORCIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCIE>(arg0, 6, b"ORCIE", b"ORCIE on SUI", b"Welcome to SUI ORCIE where we will surf the waves to the top. Join us and lets have fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985356358.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

