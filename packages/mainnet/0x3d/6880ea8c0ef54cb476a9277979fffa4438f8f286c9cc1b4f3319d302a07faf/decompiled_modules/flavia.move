module 0x3d6880ea8c0ef54cb476a9277979fffa4438f8f286c9cc1b4f3319d302a07faf::flavia {
    struct FLAVIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAVIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAVIA>(arg0, 6, b"FLAVIA", b"Flvia Is Onlin", b"$FLAVIA could emerge as the #2 AI token behind $GOAT imo. Bit of a different approach than the others bc its the 1st coin with a fully autonomous AI agent. The dev has a proven track record having already created an AI empire on Instagram with 2.5M followers & millions of views", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gam_P9_FG_Wc_A_As2_W9_87222af63a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAVIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAVIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

