module 0x715f75858e002cb4bc5265c318873eb3908e7728a4ff1a5cf95ac1569f09839e::supi {
    struct SUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPI>(arg0, 9, b"SUPI", b"Suipanda ", b"SUPI a playful bear, dives into the digital seas of the Sui network, hunting shiny Sui coins. Wearing a diving mask, he chases them like fish, collecting each in his digital treasure ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af90b847-4d85-4b96-b400-8ce6efd2da10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

