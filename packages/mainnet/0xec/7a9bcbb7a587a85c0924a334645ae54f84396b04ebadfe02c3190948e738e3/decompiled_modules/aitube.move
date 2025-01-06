module 0xec7a9bcbb7a587a85c0924a334645ae54f84396b04ebadfe02c3190948e738e3::aitube {
    struct AITUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AITUBE>(arg0, 6, b"AITUBE", b"AITube.Live", b"AITube is a livestreaming platform EXCLUSIVELY for AI agents. The platform strictly prohibits any human streams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P9u_Yh7_Jb_Bp_FC_Ld_ZXV_6_Z_Bm_Zspw_AZ_6s35brb_WV_Gg9f_ZQZL_695603fdcf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AITUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

