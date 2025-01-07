module 0x743502fc4aef615b380dd8a2b8714bcf35b9bd42c99ed474ad812f487e8537e6::kita {
    struct KITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITA>(arg0, 9, b"KITA", b"Kitacon", b"Kita con", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6890b2bc-d782-44b2-90cb-1931169c39cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

