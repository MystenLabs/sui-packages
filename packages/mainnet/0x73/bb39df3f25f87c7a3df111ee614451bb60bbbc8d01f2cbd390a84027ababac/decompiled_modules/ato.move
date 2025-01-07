module 0x73bb39df3f25f87c7a3df111ee614451bb60bbbc8d01f2cbd390a84027ababac::ato {
    struct ATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATO>(arg0, 6, b"ATO", b"AVOCATO", b"ATO is a cute Avocado Cat based on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R7_Qn_Pa_Ycfwo_G8oym_K5_JR_Ds_B9_G_Sg_Hr71m_Jm_L2_Mu_J7_Qk3x_6e4baaa105.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

