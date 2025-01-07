module 0x8e0fa4b7dfea1304ba34970bf0365a67a3efa0c9f9942070c9b19eb9e3e68ee8::depi {
    struct DEPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPI>(arg0, 9, b"DEPI", b"Depi", b"Deina sayang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/604087e0-efbc-437d-bc51-23b17887af9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

