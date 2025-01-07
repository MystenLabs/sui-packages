module 0x3ca644b1a1043beff31f82b90b0e2da44e270e9ce1144e38293e1022a0f60807::hot {
    struct HOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOT>(arg0, 9, b"HOT", b"HOT V2", b"token hot 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0075c71b-1dcf-41a1-be31-c88d545d8344.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

