module 0x84c267bf4d0ad47b0a9e3228a4a08ece9fc8fa233751b4b9240b061b7dbd77f::lily {
    struct LILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILY>(arg0, 6, b"LILY", b"THE LILY", b"LILY OF ASHWOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U_Pwro_G9t_Lz_Xv_QQ_5_CU_Xkuns9c615u_L_Zg_K_Ra3_Q5_A_Zr_PN_2_G_da86237e9a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

