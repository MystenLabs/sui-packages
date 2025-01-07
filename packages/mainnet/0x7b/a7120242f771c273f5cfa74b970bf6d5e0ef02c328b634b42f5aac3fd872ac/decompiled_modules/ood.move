module 0x7ba7120242f771c273f5cfa74b970bf6d5e0ef02c328b634b42f5aac3fd872ac::ood {
    struct OOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOD>(arg0, 9, b"OOD", b"wood", b"Firm and sturdy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a6a9029-a828-4bfa-a005-72e2fb2fd9fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

