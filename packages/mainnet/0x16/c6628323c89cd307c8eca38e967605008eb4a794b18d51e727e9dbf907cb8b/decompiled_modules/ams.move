module 0x16c6628323c89cd307c8eca38e967605008eb4a794b18d51e727e9dbf907cb8b::ams {
    struct AMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMS>(arg0, 9, b"AMS", b"Ausmanams", b"Its was created for future use ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30b086f2-0e62-4651-bfa8-3e75dab8f129.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

