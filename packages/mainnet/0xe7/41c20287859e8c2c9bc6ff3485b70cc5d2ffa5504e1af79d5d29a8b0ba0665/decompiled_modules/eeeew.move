module 0xe741c20287859e8c2c9bc6ff3485b70cc5d2ffa5504e1af79d5d29a8b0ba0665::eeeew {
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

