module 0x236ccd11bc5f44b52534ef2736b1719bfc94a45c113a8e8a8b81498b0cf2fdc::nep {
    struct NEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEP>(arg0, 9, b"NEP", b"NEPTUNE", b"Token for WAVE Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d9aa8c9-4196-4d8d-b3ba-bfb0e73a154b-1921144_1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

