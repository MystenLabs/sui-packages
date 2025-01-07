module 0xc947ec14360559f8ec6634234a69e9275d034788451d146cff2dc23539fed15c::hots {
    struct HOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTS>(arg0, 9, b"HOTS", b"HOT", b"HOT TRADING TOKEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b736a5e-cfff-43ca-811b-098f2a9b22c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

