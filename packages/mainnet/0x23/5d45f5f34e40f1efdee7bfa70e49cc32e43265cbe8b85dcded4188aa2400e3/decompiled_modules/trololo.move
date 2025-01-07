module 0x235d45f5f34e40f1efdee7bfa70e49cc32e43265cbe8b85dcded4188aa2400e3::trololo {
    struct TROLOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLOLO>(arg0, 9, b"TROLOLO", b"Trololo", b"Mr. Trololo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be63e4f0-29bd-4b70-9625-2d7c59d45419.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

