module 0x976ee5b948b098daa8489e3f1624ab3659cb3349cb7b8f4c0e04aaa64081fe43::ctalk {
    struct CTALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTALK>(arg0, 6, b"CTALK", b"Chain Talk", b"Decentralized spaces platform. Create secure chat rooms using your wallet and share invite links effortlessly. Private, trustless and secure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_H_Wc_Vz_Uj_Yx_N_Qbo4n_P8h_Uf_Tt4xa_Tvjh6u_Uu_Sw_Erq_Gk_A5_R_722aa2e645.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

