module 0x7a41dc0587499442cdd7eaf6c8a83956756251f5fb141ca3f66f6d51a395a5fa::crd {
    struct CRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRD>(arg0, 9, b"CRD", b"Crocodiles", b"Crocodile FINE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3766d87-61a3-428c-83fe-a9d583b0b754.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

