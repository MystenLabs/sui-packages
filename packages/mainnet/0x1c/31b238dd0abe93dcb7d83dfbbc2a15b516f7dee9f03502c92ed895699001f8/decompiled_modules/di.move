module 0x1c31b238dd0abe93dcb7d83dfbbc2a15b516f7dee9f03502c92ed895699001f8::di {
    struct DI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DI>(arg0, 6, b"DI", b"DIP Coin", x"74277320736f206f7665722e2043616e20796f752073757276697665207468652024444950203f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_We95ith2t_B_Wj_V17_ML_Vr3_Z5_Pbit4_Vq_Kj_Lxgqch_D_Qx_R_Fvw_84e2a054f2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DI>>(v1);
    }

    // decompiled from Move bytecode v6
}

