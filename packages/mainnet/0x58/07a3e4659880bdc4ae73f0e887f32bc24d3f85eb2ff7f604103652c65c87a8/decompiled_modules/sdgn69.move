module 0x5807a3e4659880bdc4ae73f0e887f32bc24d3f85eb2ff7f604103652c65c87a8::sdgn69 {
    struct SDGN69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDGN69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDGN69>(arg0, 9, b"SDGN69", b"SuiDegen69", b"You know degen? Yeah SuiDegen69 Is Degen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4baf2054-4abe-4e56-ba60-bdba1efe31ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDGN69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDGN69>>(v1);
    }

    // decompiled from Move bytecode v6
}

