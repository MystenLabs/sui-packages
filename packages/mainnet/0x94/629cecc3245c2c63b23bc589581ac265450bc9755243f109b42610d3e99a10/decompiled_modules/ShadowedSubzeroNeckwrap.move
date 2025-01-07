module 0x94629cecc3245c2c63b23bc589581ac265450bc9755243f109b42610d3e99a10::ShadowedSubzeroNeckwrap {
    struct SHADOWEDSUBZERONECKWRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADOWEDSUBZERONECKWRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADOWEDSUBZERONECKWRAP>(arg0, 0, b"COS", b"Shadowed Subzero Neckwrap", b"Keep it warm, for it has traveled far.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Shadowed_Subzero_Neckwrap.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHADOWEDSUBZERONECKWRAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADOWEDSUBZERONECKWRAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

