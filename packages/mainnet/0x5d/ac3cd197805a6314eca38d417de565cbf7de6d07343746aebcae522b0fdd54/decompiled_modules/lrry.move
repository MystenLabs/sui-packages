module 0x5dac3cd197805a6314eca38d417de565cbf7de6d07343746aebcae522b0fdd54::lrry {
    struct LRRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LRRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LRRY>(arg0, 9, b"LRRY", b"Larry", b"World wide acceptance token .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fc93f89-1e41-4a6b-9277-a766512eae35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LRRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LRRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

