module 0x18193e0c3ab5b1de23fcd55fec6c94ae8b9d70b0bb806debd47e55544c496a43::wedogs {
    struct WEDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOGS>(arg0, 9, b"WEDOGS", b"Dog's", b"Lets do fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0149ea4-577c-4b1f-b144-f4b08bd8f9a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

