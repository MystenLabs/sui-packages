module 0xbd4b6975e94a3e630e3a9f29ab0d1a620e5f8550a3888ca4308999b2c4c02a4d::telegram1 {
    struct TELEGRAM1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELEGRAM1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELEGRAM1>(arg0, 9, b"TELEGRAM1", b"Telegram", b"Increase active people on telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbae9e0e-8e63-4896-9427-1089e8a3b3c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELEGRAM1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TELEGRAM1>>(v1);
    }

    // decompiled from Move bytecode v6
}

