module 0xf8b0c82d25d2a0d92d74bb5c6e09e01c528b98f629fb30c7eb8ab01344cf3aa6::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUU>(arg0, 9, b"SIUUU", b"siuuuuu", b"ronaldo saying siuuu mean sui backwards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a51d7ac-6b48-481d-a88b-0a5c8a0e15f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

