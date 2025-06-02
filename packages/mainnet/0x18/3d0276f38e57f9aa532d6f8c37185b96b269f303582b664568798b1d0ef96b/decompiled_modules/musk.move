module 0x183d0276f38e57f9aa532d6f8c37185b96b269f303582b664568798b1d0ef96b::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 9, b"MUSK", b"Musk", b"Elon Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.memefi.club/landing/logo/memefi.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUSK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

