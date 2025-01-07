module 0x7326ecc77f2e739d586f52bb66af00b748c615cf1939a05124940c175077b147::aha {
    struct AHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHA>(arg0, 9, b"AHA", b"HAHA", b"LETSGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/facae47d-0844-4d29-aada-f7d69ac0aff4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

