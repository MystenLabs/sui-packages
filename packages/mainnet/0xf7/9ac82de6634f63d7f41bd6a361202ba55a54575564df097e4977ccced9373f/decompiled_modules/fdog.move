module 0xf79ac82de6634f63d7f41bd6a361202ba55a54575564df097e4977ccced9373f::fdog {
    struct FDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDOG>(arg0, 6, b"FDOG", b"Fighting Dog", b"Fighting Dog Meme  Unleash the laughter with the Fighting Dog meme!  Whether it's an epic showdown between furry friends or a hilarious take on everyday struggles, this meme captures the spirit of determination and playfulness! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z5_R_Dcb_MXB_9_J_Yq921b_F76c_Bd_G_Mc_RE_La_RS_1i_P5_Ejxrf_Hc_E_968905fde8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

