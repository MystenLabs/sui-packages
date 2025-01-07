module 0x5577cb20f4bf1d60f7195194fbf20dac474812459efa9312af7b1d9573c19308::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTA>(arg0, 9, b"SANTA", b"Santa Clau", b"Santa Claus brings gifts to everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd16a52a-c091-4702-b8b9-fb97d07e74e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

