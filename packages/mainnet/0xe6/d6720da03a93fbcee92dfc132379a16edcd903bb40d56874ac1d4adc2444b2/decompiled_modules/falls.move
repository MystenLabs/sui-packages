module 0xe6d6720da03a93fbcee92dfc132379a16edcd903bb40d56874ac1d4adc2444b2::falls {
    struct FALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALLS>(arg0, 6, b"FALLS", b"Viagra Falls", b"Legend has it, once upon a time, Earth swallowed a magical Viagra pill, and the mighty Niagara Falls was born, flowing endlessly since.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y2t_Hx_EQS_Xehg_JF_Xgz_VC_1_B_Tadbzc5_Jky_Assy8_PY_Rgr_A18_d316068448.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

