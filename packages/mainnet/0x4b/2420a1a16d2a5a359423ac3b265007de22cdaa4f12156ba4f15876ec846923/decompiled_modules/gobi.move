module 0x4b2420a1a16d2a5a359423ac3b265007de22cdaa4f12156ba4f15876ec846923::gobi {
    struct GOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBI>(arg0, 6, b"GOBI", b"Gobi on Sui", b"Meet the Mischievous lil goblin playing pranks around on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cwdjg_D54hg_TQ_Chspx_Hhir_WLQ_Wqy3_Esxtndrcp_L_Bqpump_dbd71643d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

