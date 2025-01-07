module 0x5572fad4b880e2b359527115e63d1e53533a465754960c11894cc69d946e3f48::mxpr {
    struct MXPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXPR>(arg0, 9, b"MXPR", b"MAxPro", b"Maximum Professional", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25fa016d-4611-4cc0-ba73-31bb63efdc81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

