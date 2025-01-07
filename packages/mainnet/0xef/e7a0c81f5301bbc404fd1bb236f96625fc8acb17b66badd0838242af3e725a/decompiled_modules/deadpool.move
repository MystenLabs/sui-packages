module 0xefe7a0c81f5301bbc404fd1bb236f96625fc8acb17b66badd0838242af3e725a::deadpool {
    struct DEADPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEADPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEADPOOL>(arg0, 9, b"DEADPOOL", b"Deadpool.", b"Wave pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0e2bdcf-d8d5-4046-ab82-a038f95d84bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEADPOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEADPOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

