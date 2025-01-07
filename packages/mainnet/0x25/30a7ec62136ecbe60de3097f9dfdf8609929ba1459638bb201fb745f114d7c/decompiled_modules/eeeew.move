module 0x2530a7ec62136ecbe60de3097f9dfdf8609929ba1459638bb201fb745f114d7c::eeeew {
    struct EEEEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEEEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEEEW>(arg0, 6, b"EEEEw", b"dcvdvbdbbf", b"dfdd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qpcj_K8ogj_X_Ld_Vy2jc_Ka_AUD_94tzbh_Yi_Ub_E_Be_Px_V2_JP_Se6_f3b736d167.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEEEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEEEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

