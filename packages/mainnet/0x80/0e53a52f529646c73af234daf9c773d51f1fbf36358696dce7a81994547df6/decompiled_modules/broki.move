module 0x800e53a52f529646c73af234daf9c773d51f1fbf36358696dce7a81994547df6::broki {
    struct BROKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKI>(arg0, 6, b"BROKI", b"Broki", b"Te presentamos CRIPTO BROKI, una inversin que supera los lmites de la filantropa. Garantizamos que tu contribucin impacte directamente en nios necesitados, con total transparencia y sin intermediarios.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7bf56055_707d_419f_9f50_fe3c0b0f50b0_1_1_b3be03a22f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

