module 0xc6d1ee2238ffbac2170d8e5595ae42f7ae9a0103935136bed9043564c56c3090::awawa {
    struct AWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAWA>(arg0, 6, b"AWAWA", b"Screaming Hyrax on SUI", b"No socials, just AWAWA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_J3ro_BG_7gm2_Mx_Nuc_H_Vfp9k_Yu_Fzdwte_Dxm_U_Qsa_Av5_U4rh_570bdbf28f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

