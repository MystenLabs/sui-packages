module 0x8d1bca27bf3805227baa93dfa8546fe41ec51ac88efaad59d0ec293136c3608b::hm {
    struct HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HM>(arg0, 9, b"HM", b"Ha Mai", b"HM is token of HMcaptcha.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50be0426-cb4e-4288-9a44-14ab59e4e2ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

