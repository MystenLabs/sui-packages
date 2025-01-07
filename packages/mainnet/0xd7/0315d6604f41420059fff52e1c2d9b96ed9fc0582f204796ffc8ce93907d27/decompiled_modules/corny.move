module 0xd70315d6604f41420059fff52e1c2d9b96ed9fc0582f204796ffc8ce93907d27::corny {
    struct CORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORNY>(arg0, 6, b"Corny", b"Flying smoking unicorn wif hat", x"4a7573742061206e6f726d616c20736d6f6b696e6720756e69636f726e207769662068617420666c79696e67206f6e2062616e616e610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Spy_N_Yfz_Ue_L18r_B4k7_T4t69_UX_5_VJ_3u_WLDVH_2_BT_6_TE_3mhm_7f8bfd09fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

