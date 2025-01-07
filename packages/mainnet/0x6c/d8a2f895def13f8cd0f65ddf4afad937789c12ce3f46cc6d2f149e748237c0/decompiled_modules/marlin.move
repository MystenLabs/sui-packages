module 0x6cd8a2f895def13f8cd0f65ddf4afad937789c12ce3f46cc6d2f149e748237c0::marlin {
    struct MARLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARLIN>(arg0, 9, b"MARLIN", b"MRLN", b"Marlin token with ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7f40e10-b525-4c49-8515-eb2ec5e35c5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

