module 0x6c70043fe341101afcb6eb1ec82558839237c577e5cba2387b69b7d10aa767a2::welly {
    struct WELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELLY>(arg0, 6, b"Welly", b"Welly ON SUI", b"Welly spent too much time trading meme coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qi_LN_Xan_ZJX_Qxn_R1n_Y2izwp_B_Xe_A8z4_B_Jau57pmby3_Cdj_W_b46cb7d0cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

