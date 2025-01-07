module 0x3bd7ed24bc075487f0232bc6e630ac224b5e5c389c86ca88779265006fcc8620::wmoo {
    struct WMOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMOO>(arg0, 6, b"WMOO", b"Wmoodeng", b"WRAPPED MOODENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qpcj_K8ogj_X_Ld_Vy2jc_Ka_AUD_94tzbh_Yi_Ub_E_Be_Px_V2_JP_Se6_fd86fcc715.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

