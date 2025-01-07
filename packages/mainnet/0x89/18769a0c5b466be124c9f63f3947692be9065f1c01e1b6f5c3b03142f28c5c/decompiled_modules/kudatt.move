module 0x8918769a0c5b466be124c9f63f3947692be9065f1c01e1b6f5c3b03142f28c5c::kudatt {
    struct KUDATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUDATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUDATT>(arg0, 9, b"KUDATT", b"KUDAT", b"KUDATMM king ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e8f66c0-4d93-497e-8901-540db3c39968.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUDATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUDATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

