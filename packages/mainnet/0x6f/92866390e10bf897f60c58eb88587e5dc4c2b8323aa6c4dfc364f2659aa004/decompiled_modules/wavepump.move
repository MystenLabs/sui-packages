module 0x6f92866390e10bf897f60c58eb88587e5dc4c2b8323aa6c4dfc364f2659aa004::wavepump {
    struct WAVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUMP>(arg0, 9, b"WAVEPUMP", b"Wave ", b"Wave wallet is the best project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f14a250d-4dc7-44a1-833f-7cfc3a068cb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

