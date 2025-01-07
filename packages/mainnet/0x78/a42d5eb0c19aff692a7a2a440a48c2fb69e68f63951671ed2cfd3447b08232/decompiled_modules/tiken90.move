module 0x78a42d5eb0c19aff692a7a2a440a48c2fb69e68f63951671ed2cfd3447b08232::tiken90 {
    struct TIKEN90 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKEN90, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKEN90>(arg0, 9, b"TIKEN90", b"Tiken", b"Tiken for everyone ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9ba75d2-067f-461f-8680-929dcda43d06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKEN90>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKEN90>>(v1);
    }

    // decompiled from Move bytecode v6
}

