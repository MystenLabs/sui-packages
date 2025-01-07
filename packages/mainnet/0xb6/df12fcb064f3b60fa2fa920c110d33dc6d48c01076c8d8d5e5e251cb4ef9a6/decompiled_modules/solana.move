module 0xb6df12fcb064f3b60fa2fa920c110d33dc6d48c01076c8d8d5e5e251cb4ef9a6::solana {
    struct SOLANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLANA>(arg0, 9, b"SOLANA", b"Sol", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d594a956-a9c0-45a3-97f6-8e045bf6843b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

