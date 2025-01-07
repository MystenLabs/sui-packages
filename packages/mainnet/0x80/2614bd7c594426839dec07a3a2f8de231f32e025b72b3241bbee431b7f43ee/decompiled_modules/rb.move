module 0x802614bd7c594426839dec07a3a2f8de231f32e025b72b3241bbee431b7f43ee::rb {
    struct RB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RB>(arg0, 6, b"RB", b"Rock Bottom", b"We're at Rock Bottom... now the only way is UP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zeet_UF_5_VSUZ_Zu_Nc_Zm_Fx_Bw_Nu_U_Mseg_Php1_Lk_Xru_A21o2x_X_1_13090a6202.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RB>>(v1);
    }

    // decompiled from Move bytecode v6
}

