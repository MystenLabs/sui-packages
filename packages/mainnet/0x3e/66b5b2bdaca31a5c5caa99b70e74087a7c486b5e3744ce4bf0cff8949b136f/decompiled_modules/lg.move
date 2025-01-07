module 0x3e66b5b2bdaca31a5c5caa99b70e74087a7c486b5e3744ce4bf0cff8949b136f::lg {
    struct LG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LG>(arg0, 9, b"LG", b"Legacy coi", b"Legacy coin is aimed at improving charity works ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6e39eb9-4d56-4d64-9210-50bd9ec0fbb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LG>>(v1);
    }

    // decompiled from Move bytecode v6
}

