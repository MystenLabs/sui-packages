module 0x5c395688c82ac282aa5eae00d240e450f039016b8e64df3fbe7bb7eb91036af7::glad {
    struct GLAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLAD>(arg0, 9, b"GLAD", b"Glad", b"GLAD side", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a687461-e64c-4d21-9478-2be2e839d040.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

