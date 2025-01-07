module 0x5f188af4ab2f0d273c7e7e682131afbc41c04afc5eac86f76f202c531aba4917::dan {
    struct DAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAN>(arg0, 9, b"DAN", x"4d697261636c6520e2ad90", b"Stay safe and sound ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a989fb1e-1c4b-4bc9-a017-ff91a5b8527a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

