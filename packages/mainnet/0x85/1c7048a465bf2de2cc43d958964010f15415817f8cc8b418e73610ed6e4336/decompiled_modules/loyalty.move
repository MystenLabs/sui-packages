module 0x851c7048a465bf2de2cc43d958964010f15415817f8cc8b418e73610ed6e4336::loyalty {
    struct LOYALTY has drop {
        dummy_field: bool,
    }

    struct Store has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOYALTY>(arg0, 0, b"HLP", b"Hashcase Loyalty Points", b"Hashcase Loyalty Points", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<LOYALTY>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<LOYALTY>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::allow<LOYALTY>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        0x2::token::share_policy<LOYALTY>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOYALTY>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<LOYALTY>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOYALTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun reward_user(arg0: &mut 0x2::coin::TreasuryCap<LOYALTY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<LOYALTY>(arg0, 0x2::token::transfer<LOYALTY>(0x2::token::mint<LOYALTY>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    public fun spend_points(arg0: &mut 0x2::token::TokenPolicy<LOYALTY>, arg1: 0x2::token::Token<LOYALTY>, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_request_mut<LOYALTY>(arg0, 0x2::token::spend<LOYALTY>(arg1, arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

