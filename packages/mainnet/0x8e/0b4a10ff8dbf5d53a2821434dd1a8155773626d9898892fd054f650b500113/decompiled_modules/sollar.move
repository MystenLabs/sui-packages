module 0x8e0b4a10ff8dbf5d53a2821434dd1a8155773626d9898892fd054f650b500113::sollar {
    struct SOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLLAR>(arg0, 9, b"SOLLAR", b"Bumm", b"Play to eaen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc9b1e27-47a5-4b37-aa62-b02720f97239.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

