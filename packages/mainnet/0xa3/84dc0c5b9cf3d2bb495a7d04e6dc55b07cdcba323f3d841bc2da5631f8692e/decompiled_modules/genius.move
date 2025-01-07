module 0xa384dc0c5b9cf3d2bb495a7d04e6dc55b07cdcba323f3d841bc2da5631f8692e::genius {
    struct GENIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIUS>(arg0, 6, b"GENIUS", b"Genius AI", b"Genius AI is your ultimate automated leverage trading assistant, designed to dominate the fast-paced world of crypto markets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Nq_Tc_NH_2_MN_7_Xz_KCK_Fckni27_L_Qem_Seb_F79ycyei_UKT_66k_bf527d5fb3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

