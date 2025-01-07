module 0x2bcd4e563f7564b05c405b8bb0fabf051b6914b72f76f59464e4a4875035ec79::smusk {
    struct SMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUSK>(arg0, 9, b"SMUSK", b"Suimusk", b"Suimusk is a community token created for die-hard Elon Musk partnersihip.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/907e55e9-7827-4713-b002-4202ee64fd0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

