module 0x25d047adb17d3967047d85f53350864778fd616d3cd85c3714a255ea4784029c::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"Moo Deng", x"54686520666972737420244d4f4f44454e47206f6e200a405355494e4554574f524b0a20616e64206a757374206120766972616c206c696c20686970706f206f6e20657665727920736f6369616c206d656469612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/887u_MPSQ_Jf9_QD_Ng_XVZBG_31s_Y1_Jifhs_WQ_4i_STHX_Zwpump_1_b6ed22c581.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

