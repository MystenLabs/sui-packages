module 0xf3c93b80507faf81d6e767d45fb7be196db35b753a448d02eb8370ca15953e7a::pippi {
    struct PIPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPI>(arg0, 9, b"PIPPI", b"Pippi coin", b"Pippi is funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/196503ae-ed6e-45c4-8ef7-6e136db79959.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

