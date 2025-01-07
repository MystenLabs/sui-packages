module 0xbf070db1c32fc4b8c8b39ff08c169153a0b9398784b5abbf3e34b1d7d42c5326::lesg {
    struct LESG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESG>(arg0, 9, b"LESG", b"Lsggoooo", b"To the dust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62ffb9db-84ed-47ec-993c-ad03d0224a28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESG>>(v1);
    }

    // decompiled from Move bytecode v6
}

