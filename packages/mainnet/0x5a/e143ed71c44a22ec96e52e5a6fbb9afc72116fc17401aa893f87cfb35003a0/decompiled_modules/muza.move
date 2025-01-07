module 0x5ae143ed71c44a22ec96e52e5a6fbb9afc72116fc17401aa893f87cfb35003a0::muza {
    struct MUZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUZA>(arg0, 9, b"MUZA", b"Muzaratti", b"A unique name comes from nowhere ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6648104-bfa7-492d-822e-fde6441490d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

