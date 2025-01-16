module 0x92392a449200343fa3213ab3ba877a587d3b1b2ad086e7706381c86d38ff78a::ptsui {
    struct PTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTSUI>(arg0, 6, b"PTSUI", b"Powerful Trump", b"Powerful Trump Coin symbolizes strength, success, and ambition, giving investors the tools to achieve unmatched financial growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Uk9v2_A683j_To_Vep_Es_Vf_UP_Gr_DN_Wdyb_QX_23_M_Kn76k_QECX_250c1c9fcc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

