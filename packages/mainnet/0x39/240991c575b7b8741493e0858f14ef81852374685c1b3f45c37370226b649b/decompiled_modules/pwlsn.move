module 0x39240991c575b7b8741493e0858f14ef81852374685c1b3f45c37370226b649b::pwlsn {
    struct PWLSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWLSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWLSN>(arg0, 9, b"PWLSN", b"jsnsbd", b"shebb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/941878b9-e875-4e05-8a2b-732bd83f5f62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWLSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWLSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

