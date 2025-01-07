module 0xddff1aa4baf343e61e6eaeebe814c05d456c27fd3c8e497dd0b030757530692a::sbl {
    struct SBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBL>(arg0, 9, b"SBL", b"SUBALU", b"SBL IN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/519bb49a-ce60-459a-8444-0a80b5293209-1000009817.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

