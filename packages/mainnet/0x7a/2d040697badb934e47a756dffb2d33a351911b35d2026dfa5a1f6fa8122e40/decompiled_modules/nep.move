module 0x7a2d040697badb934e47a756dffb2d33a351911b35d2026dfa5a1f6fa8122e40::nep {
    struct NEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEP>(arg0, 9, b"NEP", b"NEPTUNE", b"Token for WAVE Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b987b517-fc48-43de-89bd-0b4941a73199-1921144_1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

