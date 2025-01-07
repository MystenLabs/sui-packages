module 0xa3c2650ad7d3a2074d696fec1be48d9d007dfd475fb98f80bf8cd4a9b08cc50d::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 6, b"LOOPY", b"Loopy Love", b"Let's sprinkle some extra cuteness into the blockchain world, one coin at a time! Because in a world where everyone's so serious, let's be like Loopy  sweet, a little emotional, and proudly pink!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_X_Gmc_Y1oupb_EE_32_JDRE_Dvkjj_Fv_SU_91zf_Wh_Cwqx_V5_Gt_Dk_aaf8f6893d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

