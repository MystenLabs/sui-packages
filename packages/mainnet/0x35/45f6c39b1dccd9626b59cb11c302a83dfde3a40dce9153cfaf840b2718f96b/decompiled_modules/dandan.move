module 0x3545f6c39b1dccd9626b59cb11c302a83dfde3a40dce9153cfaf840b2718f96b::dandan {
    struct DANDAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANDAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANDAN>(arg0, 9, b"DANDAN", b"Okarun ", b"Okarun MClovin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/342c6999-4d6f-4e46-a1b8-3aa7fbda9f5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANDAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DANDAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

