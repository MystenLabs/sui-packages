module 0x7b861eb4bec9a24d66d5723e51623b2bcbfb7e8dde969e61f92742c47bcd3bf6::aped {
    struct APED has drop {
        dummy_field: bool,
    }

    fun init(arg0: APED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APED>(arg0, 6, b"Aped", b"Sea Aped", b"Aped new mover in sui with good ******* and becoming to \"King Of The Sea\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T5_M8wor_Zy68_Hu_Aodzqar_OH_00_D_Zf9_JC_1_T3_Gxp_Hs_QK_La4_ea8586e56c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APED>>(v1);
    }

    // decompiled from Move bytecode v6
}

