module 0x3323875bf4fa1602d56e29c7063b3d1f8b83f6f6b0616a9db9e94b34a236fa3d::sigma {
    struct SIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMA>(arg0, 9, b"SIGMA", b"Sigma male", b"Sigma male or alpha male", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd0272b5-6cd5-4db1-a002-73bb5f5552c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

