module 0x379db513851a34199d4dd51994f6bfbc24c380e85d90f089486e932b7ec94bd9::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 6, b"FLIP", b"Flip The Cat", x"5468652043617420466c6970730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tn_Lz2_AVR_Uhj_N_Pw6u_Rop_Y1z_E5u_JQ_Nj_H_Zk7_LG_Cdgt_Vre4_D_4d906e19e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

