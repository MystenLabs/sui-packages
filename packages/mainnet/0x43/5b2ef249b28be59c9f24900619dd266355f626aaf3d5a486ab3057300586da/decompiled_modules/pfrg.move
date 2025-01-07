module 0x435b2ef249b28be59c9f24900619dd266355f626aaf3d5a486ab3057300586da::pfrg {
    struct PFRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFRG>(arg0, 6, b"PFRG", b"Pump Frog", b"The ultimate memecoin, bringing muscle and memes to the crypto world! Join the pump with $PFRG and ride the wave of fun and gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RQG_Ewcm83wvhqi_D_Gtwjm_A_Wb2x3d_Dz_T_Kw1_Rh3cq62_S_Xuc_55f3399d8e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

