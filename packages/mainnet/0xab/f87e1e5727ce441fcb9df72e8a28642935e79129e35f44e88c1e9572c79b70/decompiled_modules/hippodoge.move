module 0xabf87e1e5727ce441fcb9df72e8a28642935e79129e35f44e88c1e9572c79b70::hippodoge {
    struct HIPPODOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPODOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPODOGE>(arg0, 6, b"HIPPODOGE", b"HIPPODOGE ON SUI", b"HIPDOG is a mix memecoin inspired by HiPPO in Mudeng and DOGE in BABY DOGE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HIPPODOGE_T_Gp_EDU_4_W1_GHL_Rs_Q56_I_1_2c56e13920.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPODOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPODOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

