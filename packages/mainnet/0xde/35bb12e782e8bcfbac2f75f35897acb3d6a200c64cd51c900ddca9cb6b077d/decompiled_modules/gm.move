module 0xde35bb12e782e8bcfbac2f75f35897acb3d6a200c64cd51c900ddca9cb6b077d::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"GMON ON SUI", b"$GM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SM_Gm_BR_2_Nd9_Hk_Bq_Cy_GS_Dp_W651_Tx_Qx1_EMQD_46t_C9bof_Pu_W_f8b8ba11cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

