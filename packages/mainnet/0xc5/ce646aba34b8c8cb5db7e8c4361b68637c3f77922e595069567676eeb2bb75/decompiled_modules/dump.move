module 0xc5ce646aba34b8c8cb5db7e8c4361b68637c3f77922e595069567676eeb2bb75::dump {
    struct DUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMP>(arg0, 6, b"Dump", b"Donald Dump", b"Inspired by President Trump's iconic appearance in a \"trash truck\" and the commentary surrounding it, $DUMP is here to bring laughter and fun to the crypto community. It's a wild ride you don't want to miss! Join the parody revolution and invest in humor with $DUMP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XABD_He46_BN_Yob_Xx_FS_Rzgg_Qd_X5_Rda_Di5o_Y_Es_PWS_No_W_Ahh_5b40922cac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

