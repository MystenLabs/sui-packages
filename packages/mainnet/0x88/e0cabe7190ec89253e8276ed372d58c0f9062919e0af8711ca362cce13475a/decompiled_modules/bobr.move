module 0x88e0cabe7190ec89253e8276ed372d58c0f9062919e0af8711ca362cce13475a::bobr {
    struct BOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBR>(arg0, 6, b"BOBR", b"BOBER KURWA", b"BOBER KURWA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3xc6_Ep2xi_Y_Tgd_MP_5m5uo_MY_Yw_Fs9b_Cuyf_Es_Sb_EVZUZ_Lgx_df5d852a3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

