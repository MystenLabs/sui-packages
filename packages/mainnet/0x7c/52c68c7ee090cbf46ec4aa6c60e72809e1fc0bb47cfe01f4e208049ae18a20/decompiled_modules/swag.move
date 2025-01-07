module 0x7c52c68c7ee090cbf46ec4aa6c60e72809e1fc0bb47cfe01f4e208049ae18a20::swag {
    struct SWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAG>(arg0, 6, b"SWAG", b"shark wif a gun", b"just a shark wif a gun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Sejse_V_Ppji_Yg_AD_Qg_J_Apue_NN_4r_N_Bqqgc_RQ_Pcig5_G_Ki_YQ_bdb0b23f46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

