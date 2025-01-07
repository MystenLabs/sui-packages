module 0x1200e9517ce92ff715b8feea636ac3dd38d435aa6d785a65c9b93bd9d83491b3::mood {
    struct MOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOD>(arg0, 6, b"MOOD", b"MOOD CAT", x"4d6f6f646361742c2066726f6d2074686520706f70756c61722054496b746f6b206d656d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R3k52oya_H_Ms_Po_Wpi_Nc_S4_Wjqtfg_G1q_Do_Ssm_Cf2_L_En_Kepx_814d72f1df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

