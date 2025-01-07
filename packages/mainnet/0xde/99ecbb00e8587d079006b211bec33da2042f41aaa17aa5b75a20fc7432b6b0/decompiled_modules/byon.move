module 0xde99ecbb00e8587d079006b211bec33da2042f41aaa17aa5b75a20fc7432b6b0::byon {
    struct BYON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYON>(arg0, 6, b"BYON", b"Beyond Infinity", b"When you realize the universe has no edge but you still gotta find it.  Beyond infinity, here I come.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T4z9qdvxgnmcs_Pe7_Gu_Dk9_B7i_S_Trxe_Zhe_Mw9_YR_Hv_Vabz4_698f8a4241.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYON>>(v1);
    }

    // decompiled from Move bytecode v6
}

