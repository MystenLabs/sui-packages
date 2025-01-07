module 0xe4e75e57e1464b8519a08dc08c4c66429484bcfeecae880dd084faa23f51c6c1::numb {
    struct NUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUMB>(arg0, 6, b"NUMB", b"Im numb to the pain", b"im numb to the pain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pwx_LR_Svvc_Nvu_Fzf4_Ea_MS_Ln4f_H5ksb6_UU_4_P_Je85fa_C_Mfa_d6cf8f6feb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

