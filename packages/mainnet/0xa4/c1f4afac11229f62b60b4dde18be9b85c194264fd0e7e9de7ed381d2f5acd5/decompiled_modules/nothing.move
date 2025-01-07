module 0xa4c1f4afac11229f62b60b4dde18be9b85c194264fd0e7e9de7ed381d2f5acd5::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTHING>(arg0, 9, b"NOTHING", b"Silly", b"Silly is SPL-404 on solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/add7edf3-3a95-4d23-b413-20c7a63a28b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

