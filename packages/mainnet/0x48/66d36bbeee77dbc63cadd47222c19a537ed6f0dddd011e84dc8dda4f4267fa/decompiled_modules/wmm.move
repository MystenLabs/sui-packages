module 0x4866d36bbeee77dbc63cadd47222c19a537ed6f0dddd011e84dc8dda4f4267fa::wmm {
    struct WMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMM>(arg0, 9, b"WMM", b"LMWMM", b"lmwmm blog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22a6cc92-effb-45b3-850b-9929f3cb860a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

