module 0xb43f31e607b74d757ea01097139b6da9ba3e93e4f269aa54746585bd0c4c2e57::kaki {
    struct KAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKI>(arg0, 6, b"KAKI", b"KAKIBABY", b"KAKI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XU_9_AU_Jsk_Yz_Xt7we_L_Fo_FZRCVL_Ku663_GC_7a_Z_Ns71hh_KK_1_K_f9c9472e31.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

