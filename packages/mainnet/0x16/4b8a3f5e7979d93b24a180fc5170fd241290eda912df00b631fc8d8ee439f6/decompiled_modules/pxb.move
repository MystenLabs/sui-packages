module 0x164b8a3f5e7979d93b24a180fc5170fd241290eda912df00b631fc8d8ee439f6::pxb {
    struct PXB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXB>(arg0, 9, b"PXB", b"PIXELBLUM", b"Pixel on blum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6ff10dc-803e-4723-89fe-c36ca77a44f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PXB>>(v1);
    }

    // decompiled from Move bytecode v6
}

