module 0xa2ec25135bab13deaae49b385dcf89200af53ecaf2b2ee9245d35d124e9ee897::ishaq {
    struct ISHAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISHAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISHAQ>(arg0, 9, b"ISHAQ", b"Wellshi ", b"Great project for all we've users ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c23e1c4-96e0-4ec8-8f25-bcb5379130ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISHAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISHAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

