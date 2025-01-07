module 0x286a951161883aa7fe52f0999d15701539859c167982ab933103aad88eb9035b::miu {
    struct MIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIU>(arg0, 6, b"MIU", b"miu miu", b"the cutest kitten in elevator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vu_Q_Pz_Tpi_TUWM_6rgm3_V9_Eh6_BU_By_Mv_S2p_JW_Yo_X_Uo_L3_TH_9_J_356c6db543.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

