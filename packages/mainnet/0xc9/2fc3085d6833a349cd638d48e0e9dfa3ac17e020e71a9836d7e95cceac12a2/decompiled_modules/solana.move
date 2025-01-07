module 0xc92fc3085d6833a349cd638d48e0e9dfa3ac17e020e71a9836d7e95cceac12a2::solana {
    struct SOLANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLANA>(arg0, 9, b"SOLANA", b"SOL", b"Muhdo Hub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f52e413e-0c70-4165-8391-a9e83da3a4c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

