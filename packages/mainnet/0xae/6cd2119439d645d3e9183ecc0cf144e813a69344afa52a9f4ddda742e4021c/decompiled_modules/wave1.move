module 0xae6cd2119439d645d3e9183ecc0cf144e813a69344afa52a9f4ddda742e4021c::wave1 {
    struct WAVE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE1>(arg0, 9, b"WAVE1", b"Wave no1", b"Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ec3c3c0-c1f3-459c-b545-399f9a4e2ee7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE1>>(v1);
    }

    // decompiled from Move bytecode v6
}

