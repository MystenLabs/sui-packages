module 0xdea6e83493f434e837807b295e1c339e5971fa460954f5aa233281052f667fe9::siak {
    struct SIAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIAK>(arg0, 9, b"SIAK", b"Siavashk", b"Best cati", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9f4aba2-d045-4b68-aa78-0938f596c50d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

