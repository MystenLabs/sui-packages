module 0x6f9ff69ebb04366e196ca2d16ba96cdf76a72fe454377c565bcace7babf08029::me {
    struct ME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ME>(arg0, 6, b"ME", b"MemEconomy", b"MemEconomy combines the best of meme culture with tokenomics. We're not just another meme token we're the economy of memes itself. Built by meme lovers, for meme lovers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zha_BKS_Bf_KGUJZK_Pvzxis_Gb_L_Ew9_Qi_W5_H_Lv_B_Av_NFP_Qk_MJ_4_dae366e22c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ME>>(v1);
    }

    // decompiled from Move bytecode v6
}

