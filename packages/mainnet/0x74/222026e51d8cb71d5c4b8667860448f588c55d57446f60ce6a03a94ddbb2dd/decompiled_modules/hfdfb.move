module 0x74222026e51d8cb71d5c4b8667860448f588c55d57446f60ce6a03a94ddbb2dd::hfdfb {
    struct HFDFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFDFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFDFB>(arg0, 9, b"HFDFB", x"d0a0d0b2d0b0d0bc", b"Bdsfc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce2733ef-27ae-41dc-9fdf-5564d776fc76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFDFB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFDFB>>(v1);
    }

    // decompiled from Move bytecode v6
}

