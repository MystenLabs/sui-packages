module 0x43e84d8d557e7a9a7f9d096cd928453a184e3ddab88000557bdd073bf71ec340::gib {
    struct GIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIB>(arg0, 6, b"GIB", b"GIB MONEY", b"GIB ME MONEY, NO SOCIALS, JUST PUSH, WILL BURN SUPPLY AND PAY TRENDING ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zb_YAM_8je_Jn_Tpr_Bnor9n_Ajv_PR_69b_Rbuo_RX_Hmef3chk3w_U_7bc9e4e741.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

