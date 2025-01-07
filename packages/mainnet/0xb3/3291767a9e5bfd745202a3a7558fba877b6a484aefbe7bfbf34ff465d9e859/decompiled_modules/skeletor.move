module 0xb33291767a9e5bfd745202a3a7558fba877b6a484aefbe7bfbf34ff465d9e859::skeletor {
    struct SKELETOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKELETOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKELETOR>(arg0, 6, b"SKELETOR", b"SKELETOR SUI", b"Skeletor has come from the depths of snake mountain to take over the base chain nehehehe *laughs in skeletor*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ri_JC_Eu1_Fye_Qcb_Sr_UV_5_V_Sx_N5vfwpdr_Y_Yc1_R551_Sq_EMYMX_24da56a80e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKELETOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKELETOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

