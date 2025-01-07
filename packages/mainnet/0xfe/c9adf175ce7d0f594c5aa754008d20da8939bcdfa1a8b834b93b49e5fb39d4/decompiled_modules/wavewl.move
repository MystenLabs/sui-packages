module 0xfec9adf175ce7d0f594c5aa754008d20da8939bcdfa1a8b834b93b49e5fb39d4::wavewl {
    struct WAVEWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEWL>(arg0, 9, b"WAVEWL", b"shrimp", b"Hi wave shrimp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba013609-68b5-412c-ac72-1b327afb8060.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

