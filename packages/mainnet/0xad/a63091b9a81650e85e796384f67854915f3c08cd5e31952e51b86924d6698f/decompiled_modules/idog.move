module 0xada63091b9a81650e85e796384f67854915f3c08cd5e31952e51b86924d6698f::idog {
    struct IDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDOG>(arg0, 9, b"IDOG", b"Kuyuk", b"IDOG is an ancient legend that became my inspiration for the uni token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7a99b5f-49c2-4b8e-aff3-beb5bb4255fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

