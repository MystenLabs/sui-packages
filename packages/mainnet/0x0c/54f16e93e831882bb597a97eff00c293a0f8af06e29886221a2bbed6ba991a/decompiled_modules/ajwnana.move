module 0xc54f16e93e831882bb597a97eff00c293a0f8af06e29886221a2bbed6ba991a::ajwnana {
    struct AJWNANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AJWNANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJWNANA>(arg0, 9, b"AJWNANA", b"Auajnana", b"Djakakdndj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ff4319e-b557-4095-ab49-fa8e93f73597.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJWNANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJWNANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

