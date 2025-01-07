module 0x32352625ac7e1de7f7d21ec25bbdb62211bb6f8611c372f29f03405dbcb8a587::floo {
    struct FLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOO>(arg0, 6, b"FLOO", b"FLOO ON SUI", x"466c6f6f73206d65616e73206d6f6e6579200a206f6e2023736f6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/75_Dv_Rj_T_Dpa_Ebrd_UH_Vomdjfsi_Xb_Bi5_Fw_Nycty_Ugf_Loo_S_bb5b087942.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

