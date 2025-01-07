module 0x6b273f638d0a264c10f0d4640b51e764ef76ffe138897dc25cdd21f776df25cf::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUS>(arg0, 6, b"ZEUS", b"SUIZEUS", x"4920616d2074686520666972737420474f4420746f6b656e206f6e20235355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Mzl_Rf_UR_400x400_f5413a64eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

