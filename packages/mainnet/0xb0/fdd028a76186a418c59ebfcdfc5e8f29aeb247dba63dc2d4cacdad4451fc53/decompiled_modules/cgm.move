module 0xb0fdd028a76186a418c59ebfcdfc5e8f29aeb247dba63dc2d4cacdad4451fc53::cgm {
    struct CGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGM>(arg0, 9, b"CGM", b"C game", b"For posterity and along with the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e1d6a20-26fd-4645-9f8c-572af4cbb0d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

