module 0x93bbc12675e2bce1ba2026fab1917d22160642f97a95be562892020cb3374102::father {
    struct FATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATHER>(arg0, 9, b"FATHER", b"Fatherpapa", b"papa is a sol meme that deserves to be honored, we have the right to hope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdde8951-a781-4892-a9a3-bb282e2cfd15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

