module 0x4832bc26d4bb0d0f31824b23174b6333e97a65a2d6dc44ca9c545a878a045548::cvg {
    struct CVG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CVG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CVG>(arg0, 6, b"CVG", b"Creeper Van Goh", b"AI generated Minecraft paintings in the style of Van Goh.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uh_R_Dco_Y_Se_KDAU_8_Xv_Uq_U_Gwbpsv_Bm_H_Xk_K2768c_Jt_W3_L1x_G_c47afd3f24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CVG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CVG>>(v1);
    }

    // decompiled from Move bytecode v6
}

