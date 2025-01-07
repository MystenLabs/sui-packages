module 0x93b738e6cbf3643c586e422a3083f6039e6669cd3f5842daebdfc0f6b82456f5::timefarm {
    struct TIMEFARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMEFARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMEFARM>(arg0, 9, b"TIMEFARM", b"Time Farm", b"Maximize your productivity and earn tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01e916dc-f5bd-4990-8227-7181ac4b2b0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMEFARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIMEFARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

