module 0x855edec87e9b5c3559837cbf036a3114670f63b9c0a3b8a3bce12c5882a206b0::cts {
    struct CTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTS>(arg0, 9, b"CTS", b"CATSUI", b"Kucing dijaringan sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1c31844-8a51-44a0-9f49-074811c06308.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

