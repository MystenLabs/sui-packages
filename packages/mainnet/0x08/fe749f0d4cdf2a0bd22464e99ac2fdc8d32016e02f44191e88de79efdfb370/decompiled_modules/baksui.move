module 0x8fe749f0d4cdf2a0bd22464e99ac2fdc8d32016e02f44191e88de79efdfb370::baksui {
    struct BAKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSUI>(arg0, 6, b"Baksui", b"Bakso On Sui", x"42616b736f204f6e20537569202c20746865206e65776573742053756d617472616e20746967657220637562206174204469736e65797320416e696d616c204b696e67646f6d0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rj2_UA_3_R9_Nenjm_Sq13bv9_Lq_Wy_AC_3_Hj9o_B_Qmq5_Kwn_ZMM_Xo_85da9e5f4b_5461fa9464.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

