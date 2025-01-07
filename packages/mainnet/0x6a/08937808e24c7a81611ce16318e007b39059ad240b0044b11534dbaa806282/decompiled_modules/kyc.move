module 0x6a08937808e24c7a81611ce16318e007b39059ad240b0044b11534dbaa806282::kyc {
    struct KYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYC>(arg0, 6, b"KYC", b"Keep Your Cash", b"Keep Your Cash ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmamd_N1b_Mtoe_VZH_Pm_DND_94_Kkc_Ah_T5b_R_Hw_Cv_Dpi_Ywi_Gb6fn_86f46963f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

