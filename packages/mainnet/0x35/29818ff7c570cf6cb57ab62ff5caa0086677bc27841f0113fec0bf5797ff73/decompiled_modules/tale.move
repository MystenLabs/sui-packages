module 0x3529818ff7c570cf6cb57ab62ff5caa0086677bc27841f0113fec0bf5797ff73::tale {
    struct TALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TALE>(arg0, 6, b"TALE", b"Tale of Legends", x"4120636f6c6c656374696f6e206f662074686520776f726c6427732067726561746573742074616c6573206c6f636b656420696e73696465206d656d652063756c747572652e203230323520626567616e207769746820666561722e204c6574207573206669676874206261636b20616e642072656d656d62657220746865206c6567656e647320776520617265206275696c742075706f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Kjv_T_Bk_DJ_Bpirvf5_Bd9m8j_Bwme_Ti9_Wt82n_Ucyyra_F6xg_79ff242d65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

