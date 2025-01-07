module 0x4c06fd8bd7180da823876e18689b2778a25b50f3c440bc59b0d668240c8ce297::r_sgm {
    struct R_SGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: R_SGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R_SGM>(arg0, 9, b"R_SGM", b"ryan sigma", b"This is crypto friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/730fa1c3-a306-4005-a363-9a3bf4934899.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R_SGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R_SGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

