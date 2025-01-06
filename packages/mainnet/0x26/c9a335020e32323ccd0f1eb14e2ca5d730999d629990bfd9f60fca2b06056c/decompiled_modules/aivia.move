module 0x26c9a335020e32323ccd0f1eb14e2ca5d730999d629990bfd9f60fca2b06056c::aivia {
    struct AIVIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIVIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIVIA>(arg0, 6, b"AIVIA", b"AI Virtual Agents", b"$AIVIA is a dynamic cryptocurrency at the core of the AI Virtual Agents ecosystem which is currently built for Solana Future support planned for BASE and BNB Smart Chain, ensuring multi-chain compatibility and increased user access.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ysz_D9_BC_1keq_Y_Lzt4b_E_Bdrmeoo_Q38_Zc_Ckt_TV_Qc_MU_27_RB_9_71dd0b67a8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIVIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIVIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

