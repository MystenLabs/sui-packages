module 0xf2e9b658a001aa53a672b2355edefc579ff35ca935cd3eac0b9505cd99ca7483::autista {
    struct AUTISTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTISTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTISTA>(arg0, 6, b"AUTISTA", b"autista cat", b"autista cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ujhi_E4g_Ajv7t_A_Sdxf5_Ck_Kvfk4f_Rq_Ws7_UXR_7k_Bn_Q7_PSBW_fcd509d47c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTISTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTISTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

