module 0x89af0301a795f6eb23d74160ca86c02b8f8ab3a4c9fca80f5d962e6d0522b128::tism {
    struct TISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISM>(arg0, 6, b"TISM", b"TISM on Sui", b"gtism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955805131.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TISM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

