module 0x7099c25339c903ff4d763ff5849745bb35ad7e26dcd83c5b3d0a25abd53d3de6::aee {
    struct AEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEE>(arg0, 6, b"AEE", b"Artificial Programming Engine", b"AEF COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NT_5m_E5sm_E1_THE_4c_F33jb_Ca_B4_W_Hxs_Xtg5x_N_Vmr_B_Xh_B_Az6_753fef384f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

