module 0x14ba70d359a7e3bfaa0978a1b6c0faa76e70af49ea467e423614cc44823539a0::llm {
    struct LLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLM>(arg0, 6, b"LLM", b"LLMEMECOIN", b"The first LLM memecoin, trained by CT degens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bb_Fq_M_Mf_Df_L_Nhr832i_Kthvyeg_YX_Qo_A_Lz16kdt_J_Mj_Npump_f4ac32542b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

