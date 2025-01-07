module 0xbc70e139fb62550fce12206d23022b291100bb23759116b09f90a219b3a9609f::supi {
    struct SUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPI>(arg0, 9, b"SUPI", b"Suipanda ", b"SUPI a playful bear, dives into the digital seas of the Sui network, hunting shiny Sui coins. Wearing a diving mask, he chases them like fish, collecting each in his digital treasure ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01b38e6f-1797-4da5-ba2a-4b9362c79753.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

