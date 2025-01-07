module 0xb86d60dbb8f650316f534d954a3fe88f6fe06fd3f77947d0283977690287ebb3::pxl {
    struct PXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXL>(arg0, 9, b"PXL", b"PIXEL", b"This pixel coin shows the million people's coins that are on any chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c7623a9-265b-4b26-a4ca-ff2eb696a1c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PXL>>(v1);
    }

    // decompiled from Move bytecode v6
}

