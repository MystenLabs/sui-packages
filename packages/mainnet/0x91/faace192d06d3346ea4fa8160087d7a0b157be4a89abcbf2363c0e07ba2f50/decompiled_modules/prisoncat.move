module 0x91faace192d06d3346ea4fa8160087d7a0b157be4a89abcbf2363c0e07ba2f50::prisoncat {
    struct PRISONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRISONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRISONCAT>(arg0, 6, b"PrisonCat", b"Prison Cat", b"I didn't make any mistakes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Saqiv9_Xrjr_G_Wj9gh_M26au5peyi1j6xt2_K_Fg_D8_ENE_Zsim_35eb595b6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRISONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRISONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

