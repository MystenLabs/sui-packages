module 0x34f71c64f39a7705d6dbf67079131b5dcfa8f6e851abf8378c4772c86952b8d8::rtrump {
    struct RTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTRUMP>(arg0, 9, b"RTRUMP", b"Royaltrump", b"Trump is him ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c13fe42-7154-4753-a2c7-ad5cbdd497fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

