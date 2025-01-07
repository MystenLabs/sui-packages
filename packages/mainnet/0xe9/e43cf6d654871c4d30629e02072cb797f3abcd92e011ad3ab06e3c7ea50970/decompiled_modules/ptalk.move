module 0xe9e43cf6d654871c4d30629e02072cb797f3abcd92e011ad3ab06e3c7ea50970::ptalk {
    struct PTALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTALK>(arg0, 9, b"PTALK", b"PitchTalk", b"18", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e7b0bc4-4432-492a-9248-b578006d6065.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

