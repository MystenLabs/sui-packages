module 0x26d1e073c37e07238acde67a162c33b8470ab9bb0d90b55ebce999fcf642e3c6::lumiraai {
    struct LUMIRAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMIRAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMIRAAI>(arg0, 6, b"LUMIRAAI", b"LUMIRA AI", x"244c554d49524149202d20796f75722063757465737420414920617373697374616e740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sr_EZ_2_Ng_Nir_DL_Mcop_QZLH_5_RDM_7zdf_Fb_Ys_Zo_Pd_V7_P5w6mf_fb30ed3146.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMIRAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMIRAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

