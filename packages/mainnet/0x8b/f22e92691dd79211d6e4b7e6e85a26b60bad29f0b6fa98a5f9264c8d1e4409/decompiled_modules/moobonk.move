module 0x8bf22e92691dd79211d6e4b7e6e85a26b60bad29f0b6fa98a5f9264c8d1e4409::moobonk {
    struct MOOBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOBONK>(arg0, 6, b"MOOBONK", b"MOODENG BONK", x"353025204d4f4f44454e472035302520424f4e4b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SF_Nr_Xd_HXM_Yn_Wj_F7_J_Sv9_W8_Q7_Mo_Gfbm_Rah_C3_M_Tm8_Cnv_Qvb_0d3f0d5a8d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOBONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

