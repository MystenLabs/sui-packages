module 0xbe0e81997d668a629c06d5fed7c80e1e5090e90db20f20158ecbeee8fea1e306::xgala {
    struct XGALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XGALA>(arg0, 9, b"XGALA", b"GALAx", b"GALAXI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a63add4-9c05-4aa5-9a1a-a6f66b4ea4dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XGALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

