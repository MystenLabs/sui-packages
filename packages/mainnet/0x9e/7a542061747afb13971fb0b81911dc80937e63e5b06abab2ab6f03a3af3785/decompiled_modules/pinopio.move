module 0x9e7a542061747afb13971fb0b81911dc80937e63e5b06abab2ab6f03a3af3785::pinopio {
    struct PINOPIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINOPIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINOPIO>(arg0, 9, b"PINOPIO", b"Pinopio", b"Pinopio geng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/646c0a93-f543-4f77-93b8-a3cf85520029.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINOPIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINOPIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

