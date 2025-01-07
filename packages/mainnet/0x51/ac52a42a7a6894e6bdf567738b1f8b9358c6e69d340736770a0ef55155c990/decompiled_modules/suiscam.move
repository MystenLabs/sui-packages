module 0x51ac52a42a7a6894e6bdf567738b1f8b9358c6e69d340736770a0ef55155c990::suiscam {
    struct SUISCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISCAM>(arg0, 9, b"SUISCAM", b"scam", b"nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f98f6a2f-20f0-45db-bf19-be03e5ccfd0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

