module 0x9d637b25862507886f23c6c9fbc15501265f51aba01324c5564abe56e4dd55a6::pdms {
    struct PDMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDMS>(arg0, 6, b"PDMS", b"ParaDigmStories", b"paradigmstories (PARA)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZM_Sd_Fs3_SDX_5_Paz_MDE_6_Ei_SDAC_3qw_U5g4_A_Nte9f_Pm_XA_Kqb_6548db34d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

