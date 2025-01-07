module 0xc900e6bb3ac903d65bc13892986b31d3eae4735012f9d0dfffd0891a582e9988::rageguy {
    struct RAGEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGEGUY>(arg0, 6, b"RAGEGUY", b"RAGE GUY", x"49207761732061626f757420746f2062652073656c6c2074686520746f702e2e2e207468656e2044455653205255474745442120464646464646555555555555555555552d20554e49544520494e20414e47455220414741494e53542053484954545920444556532057495448205241474520475559210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vj_Eu_Z86_Tuk_P5_F_Ucyd1h_CX_2_PRY_Rr_W_Tpt_Ba_RFV_8_Er_Qek_Tb_4f12bb72cf.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGEGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAGEGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

