module 0x7b5d4c17be7abd290140207ab99d10f6c0139734676086b71cc4237dc4f16e6f::axl {
    struct AXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXL>(arg0, 9, b"AXL", b"Axolotl", b"Axolotl in minecraft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b2a3a72-3aba-41a5-afd9-08d50970c249.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXL>>(v1);
    }

    // decompiled from Move bytecode v6
}

