module 0x53f19aa24e22fbbf91c0d5afe270b8b88382b2b25300eeddb61f6a66483b793c::plsx {
    struct PLSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLSX>(arg0, 9, b"PLSX", b"PULSEX", b"DEX ON PULSECHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5e00a59-8f4f-4ae3-9658-19fca85157c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

