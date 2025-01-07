module 0x41c670e8c8a439b03f32c8cfdb9095e4668bae2d7fc5d89b55f93626d632cdc9::cp {
    struct CP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CP>(arg0, 6, b"CP", b"OG Pudgy Penguin", x"50756467792050656e6775696e206f6720697320636c75622070656e6775696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xqfr_Kt_Txu763_R_Nf_Sky_Jx_ZXX_4_Bni_MV_9t_H_To5ce_VTB_Vohm_fa0ca599e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CP>>(v1);
    }

    // decompiled from Move bytecode v6
}

