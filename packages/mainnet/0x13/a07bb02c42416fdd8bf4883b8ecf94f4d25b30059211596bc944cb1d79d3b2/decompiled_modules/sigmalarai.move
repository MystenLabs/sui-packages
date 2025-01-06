module 0x13a07bb02c42416fdd8bf4883b8ecf94f4d25b30059211596bc944cb1d79d3b2::sigmalarai {
    struct SIGMALARAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMALARAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMALARAI>(arg0, 6, b"SIGMALARAI", b"SigmalaraAI", b"Dive into a futuristic realm where cryptic code meets advanced intelligence. We bring you the next generation of decentralized synergy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_WEGE_En3zbmrxuxcjt_PM_Vo_Tp_A_Lsxe_WX_Mw_XNWYS_1_D8_RT_Gt_375055f039.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMALARAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGMALARAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

