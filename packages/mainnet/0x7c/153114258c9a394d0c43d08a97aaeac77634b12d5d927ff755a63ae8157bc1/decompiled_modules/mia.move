module 0x7c153114258c9a394d0c43d08a97aaeac77634b12d5d927ff755a63ae8157bc1::mia {
    struct MIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIA>(arg0, 6, b"MIA", b"SUIMIA", b"With her soft fur, playful whiskers, and graceful movements, MIA the cat has quickly become one of the most beloved characters in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XU_9_AU_Jsk_Yz_Xt7we_L_Fo_FZRCVL_Ku663_GC_7a_Z_Ns71hh_KK_1_K_56fed88ee4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

