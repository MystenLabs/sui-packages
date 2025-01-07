module 0x2c61cf8b45a45e381ade7ee0590eee064305c5afef0d8b59612005253d537db::pike {
    struct PIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKE>(arg0, 6, b"PIKE", b"PIKE THE DINO", b"Meet PIKE, legendary with Pepe, Brett,Ponke, and Peng, known for his thrill-seeking nature in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xhiz_JJKM_9nx_NS_Biu_Kss27_K2z_J_Pfka_Cjtc54o_J_Dqbdq_F9_e23de3f826.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

