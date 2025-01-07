module 0x98baf13b1d72076ad729a4f2fa4432ab644d42373ea56745c6bcb76c008b5258::nuha {
    struct NUHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUHA>(arg0, 9, b"NUHA", b"Ulin", b"Nft erenanmskm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3dff378-cb99-438d-88af-53b72ae7f088.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

