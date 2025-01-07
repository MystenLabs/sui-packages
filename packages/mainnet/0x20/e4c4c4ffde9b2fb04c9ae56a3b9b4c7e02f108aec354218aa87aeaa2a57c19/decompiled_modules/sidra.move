module 0x20e4c4c4ffde9b2fb04c9ae56a3b9b4c7e02f108aec354218aa87aeaa2a57c19::sidra {
    struct SIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDRA>(arg0, 9, b"SIDRA", b"Chain", b"Sidra meme token. Buy sidra meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9ce9147-03c7-45a0-8f8c-1fa684481aad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIDRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

