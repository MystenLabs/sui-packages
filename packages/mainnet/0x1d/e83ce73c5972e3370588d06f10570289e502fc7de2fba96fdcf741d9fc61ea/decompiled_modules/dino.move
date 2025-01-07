module 0x1de83ce73c5972e3370588d06f10570289e502fc7de2fba96fdcf741d9fc61ea::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"DINO SUI", b"DINO DINO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Uv_MHW_Dh7_Cfoc_M_Tfk5_Suh_E_Lc_NT_Xo_Usho_Y8_C_Rc_Byu_A1w_T_a01279a941.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

