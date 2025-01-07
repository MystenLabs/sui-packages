module 0x23d6aa29429ae5e47109bd946ae3ce76869c7405c10465c000a2d5f08fd1d222::sui8x {
    struct SUI8X has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI8X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI8X>(arg0, 6, b"SUI8x", b"sui sui sui sui sui sui sui and sui", b"sui sui sui sui sui sui sui and sui...8x sui and more? Lets make SUI the meme platform of the crypto space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_logo_with_the_text_sui_8x_on_a_wooden_plank_the_rz_P2_ZCANT_Oab_Tv_V_Pimzfqw_DHJ_6_Ztos_TYKY_h_Xrz_Ag_ELA_b20619c197.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI8X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI8X>>(v1);
    }

    // decompiled from Move bytecode v6
}

