module 0xe74560017f1a308274cf1408e0e1e4f95272b808b8c238305be3896fdf09bd3c::m_xtt {
    struct M_XTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_XTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_XTT>(arg0, 9, b"M_XTT", b"Maxicoin", x"41206d656d6520636f696e20f09faa99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe700c92-c7aa-4685-b38c-bcd41c50e6a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_XTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_XTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

