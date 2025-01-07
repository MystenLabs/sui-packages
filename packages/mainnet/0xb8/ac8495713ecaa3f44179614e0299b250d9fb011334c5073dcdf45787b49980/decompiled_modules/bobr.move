module 0xb8ac8495713ecaa3f44179614e0299b250d9fb011334c5073dcdf45787b49980::bobr {
    struct BOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBR>(arg0, 6, b"BOBR", b"Bober Kurwa", b"Bober! Ej, kurwa, bober! Bober!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3xc6_Ep2xi_Y_Tgd_MP_5m5uo_MY_Yw_Fs9b_Cuyf_Es_Sb_EVZUZ_Lgx_a821c283a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

