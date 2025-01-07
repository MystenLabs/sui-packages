module 0x4320a3d9bf8b67aaa91ef1fbe2783adb05aa112faa2bc244865ad82730a533c2::ponyo {
    struct PONYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONYO>(arg0, 6, b"PONYO", b"Ponyo Frog Cat", b"TikTok cat Ponyo with 30M views, he really wants to be a frog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Zf_Yf2_Vq_F_Kzn_Udmn_Dv_Ac_EZ_7_EAK_5u61q_B_Chymyo_W_Zpump_ab5c06109c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

