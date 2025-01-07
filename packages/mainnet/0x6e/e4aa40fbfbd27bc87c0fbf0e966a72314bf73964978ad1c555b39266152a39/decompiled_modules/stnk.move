module 0x6ee4aa40fbfbd27bc87c0fbf0e966a72314bf73964978ad1c555b39266152a39::stnk {
    struct STNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STNK>(arg0, 6, b"STNK", b"I Just Farted", x"69206a757374206661727465642e20206966206f6e6c79207468657265207761732061206d656d65636f696e2061626f757420746861740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QQ_Hp99_VD_Vy1578_BK_6_Piyy_M3np_MHE_Ad63wns1_Wn_Rio_Tg_R_858a00b747.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

