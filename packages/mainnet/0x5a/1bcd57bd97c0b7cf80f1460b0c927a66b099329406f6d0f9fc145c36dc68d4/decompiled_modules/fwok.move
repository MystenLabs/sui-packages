module 0x5a1bcd57bd97c0b7cf80f1460b0c927a66b099329406f6d0f9fc145c36dc68d4::fwok {
    struct FWOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOK>(arg0, 6, b"FWOK", b"Fwok", b"\"PEPE The Frog\" but did you know that the inspiration came from an old comic book called \"Big Yum Yum Book\" featuring The Story of OG FWOK !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Zpcj_A_Ty_Zp_Y_Ny5_Gm5_Rpnd36_NA_Zuc_Sp_Ns8oxiwdq_Fg_N1m_52678847d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

