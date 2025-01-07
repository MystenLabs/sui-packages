module 0x30643d162f9ad646988ee3c6f2a09119d326a82a04ea853ff468d13bef277fc3::qntc {
    struct QNTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QNTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QNTC>(arg0, 9, b"QNTC", b"QUANTICO ", b"Quantico ($QNTC) is a revolutionary memecoin designed for the tech-savvy and future-focused. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b61a486e-c3a2-45df-8438-6c0a8cb338f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QNTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QNTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

