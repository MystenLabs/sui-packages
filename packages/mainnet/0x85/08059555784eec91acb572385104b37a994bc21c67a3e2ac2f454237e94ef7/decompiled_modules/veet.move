module 0x8508059555784eec91acb572385104b37a994bc21c67a3e2ac2f454237e94ef7::veet {
    struct VEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEET>(arg0, 9, b"VEET", b"Vee", b"A token for abandoned animals ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7912e068-2f5a-47ea-b156-6cffc5777b73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

