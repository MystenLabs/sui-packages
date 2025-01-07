module 0x627cb5f8cfb5a7999683774a27a6a64fa2598ba7f5cc551eec280cb0ddc59d58::bakso {
    struct BAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSO>(arg0, 6, b"BAKSO", b"BAKSO TIGER", b"BAKSO!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rj2_UA_3_R9_Nenjm_Sq13bv9_Lq_Wy_AC_3_Hj9o_B_Qmq5_Kwn_ZMM_Xo_85da9e5f4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

