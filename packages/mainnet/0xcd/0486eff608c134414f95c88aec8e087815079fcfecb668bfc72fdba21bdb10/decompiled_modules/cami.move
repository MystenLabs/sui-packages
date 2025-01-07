module 0xcd0486eff608c134414f95c88aec8e087815079fcfecb668bfc72fdba21bdb10::cami {
    struct CAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAMI>(arg0, 9, b"CAMI", b"Milo Cats", b"Milo is an adorable cartoon-style cat with a charming personality. With big, round eyes and small, triangular ears, Milo always looks curious and playful. His soft, fluffy fur in light beige and white gives him a cozy and huggable appearance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/603287ee-21b0-45e8-b0c8-43ad8a601a9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

