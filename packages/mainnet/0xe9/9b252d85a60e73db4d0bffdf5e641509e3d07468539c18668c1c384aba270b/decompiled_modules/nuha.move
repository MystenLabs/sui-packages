module 0xe99b252d85a60e73db4d0bffdf5e641509e3d07468539c18668c1c384aba270b::nuha {
    struct NUHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUHA>(arg0, 9, b"NUHA", b"Ulin", b"Nft erenanmskm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/359d5a97-9c0e-4ff6-ab61-d5392d892ee8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

