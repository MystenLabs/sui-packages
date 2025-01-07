module 0x7dc3486754be5cd0d893b9c0c595bab18cc19389d96e9bedbd1fc3ffeb5fb240::huc {
    struct HUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUC>(arg0, 9, b"HUC", b"Hurga", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fcfb901-773c-43fc-880e-b0d63eab9d7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

