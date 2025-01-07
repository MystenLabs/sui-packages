module 0x62c07357e31cea5dde957b7b3abb263c4a15b517d2159a5b8f234be566d1ce46::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASS>(arg0, 6, b"ASS", b"WE LOVE ASS", x"4120636f6d6d756e697479206f66202441535320656e74687573696173747320756e6974656420746f676574686572206f6e205375692e0a0a5765206c6f766520617373202d20426967206f7220736d616c6c207765206c6f7665207468656d20616c6c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cfgm_B9i_TWA_Bd_Yh3_CHQQDU_Gt_Wy18r_MNAE_Eqyp4_Gr_Jpump_53fd4cac76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

