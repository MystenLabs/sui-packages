module 0x2876a73c64400720a3736f1d2cfe30ef53bfba68d026588110008b54bcfcbd9f::huule {
    struct HUULE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUULE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUULE>(arg0, 9, b"HUULE", b"Huu1", b"Huu huu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3c2feb0-16e1-4607-b795-01b4721419ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUULE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUULE>>(v1);
    }

    // decompiled from Move bytecode v6
}

