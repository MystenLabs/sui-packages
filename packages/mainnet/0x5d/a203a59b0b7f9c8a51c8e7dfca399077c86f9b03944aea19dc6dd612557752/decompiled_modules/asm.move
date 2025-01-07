module 0x5da203a59b0b7f9c8a51c8e7dfca399077c86f9b03944aea19dc6dd612557752::asm {
    struct ASM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASM>(arg0, 9, b"ASM", b"Asulm", b"Beloved mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e1b27dc-34cc-43b5-bb2b-11d5f5cb8a3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASM>>(v1);
    }

    // decompiled from Move bytecode v6
}

