module 0xbd33ccc3e027fcc2619e5decdc47090ae0d6582dd10c3095354a9242ed3af1f9::trumpe {
    struct TRUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPE>(arg0, 6, b"TRUMPE", b"$TRUMPE", b"$TRUMPE is ready to conquer the MATRIX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001286056.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

