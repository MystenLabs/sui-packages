module 0xd3473aedf94512296c58d9d227f6e60f05ed0157ad976aee597a07f0140a8306::karin {
    struct KARIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARIN>(arg0, 9, b"KARIN", b"Karin dog", b"Karina", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f36513c8-2e67-4f2c-a6f8-fb6ff3ec0f05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KARIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

