module 0xafbab7002a507f8a019920d8832f9109c483526bb9ecd664021ee4f7715b0d20::scho {
    struct SCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHO>(arg0, 9, b"SCHO", b"arthur", b"arthurschopenhauer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dc46380-44c0-440e-9caf-ff6807f3fe06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

