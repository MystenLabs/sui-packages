module 0x3281eadb70a041c75341e327e720635268309cce5fd2799113c4e8994a94fbc5::ngens {
    struct NGENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGENS>(arg0, 9, b"NGENS", b"Ngenskuy", b"You're only ngenskuy once!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fec05985-acc4-43c4-bc77-cd7a259f18f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

