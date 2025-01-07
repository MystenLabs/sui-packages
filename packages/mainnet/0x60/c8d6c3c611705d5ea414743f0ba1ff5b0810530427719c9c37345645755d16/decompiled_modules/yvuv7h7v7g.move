module 0x60c8d6c3c611705d5ea414743f0ba1ff5b0810530427719c9c37345645755d16::yvuv7h7v7g {
    struct YVUV7H7V7G has drop {
        dummy_field: bool,
    }

    fun init(arg0: YVUV7H7V7G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YVUV7H7V7G>(arg0, 9, b"YVUV7H7V7G", b"7v766g77g", b"Tttct", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/308b50e1-3e2b-4f0c-a9a5-9ec8f0e63558.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YVUV7H7V7G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YVUV7H7V7G>>(v1);
    }

    // decompiled from Move bytecode v6
}

