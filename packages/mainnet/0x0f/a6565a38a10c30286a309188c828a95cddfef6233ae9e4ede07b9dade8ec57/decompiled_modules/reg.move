module 0xfa6565a38a10c30286a309188c828a95cddfef6233ae9e4ede07b9dade8ec57::reg {
    struct REG has drop {
        dummy_field: bool,
    }

    entry fun spend(arg0: &mut 0x2::token::TokenPolicy<REG>, arg1: &mut 0x2::token::Token<REG>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::spend<REG>(0x2::token::split<REG>(arg1, arg2, arg3), arg3);
        0xfa6565a38a10c30286a309188c828a95cddfef6233ae9e4ede07b9dade8ec57::denylist_rule::verify<REG>(arg0, &mut v0, arg3);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<REG>(arg0, v0, arg3);
    }

    entry fun transfer(arg0: &0x2::token::TokenPolicy<REG>, arg1: 0x2::token::Token<REG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::transfer<REG>(arg1, arg2, arg3);
        0xfa6565a38a10c30286a309188c828a95cddfef6233ae9e4ede07b9dade8ec57::denylist_rule::verify<REG>(arg0, &mut v0, arg3);
        let (_, _, _, _) = 0x2::token::confirm_request<REG>(arg0, v0, arg3);
    }

    fun init(arg0: REG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REG>(arg0, 6, b"t-USDY", b"Test USDY", b"Ondo Test USDY Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<REG>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<REG>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        0x2::token::allow<REG>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::add_rule_for_action<REG, 0xfa6565a38a10c30286a309188c828a95cddfef6233ae9e4ede07b9dade8ec57::denylist_rule::Denylist>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        0x2::token::add_rule_for_action<REG, 0xfa6565a38a10c30286a309188c828a95cddfef6233ae9e4ede07b9dade8ec57::denylist_rule::Denylist>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REG>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<REG>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REG>>(v1);
        0x2::token::share_policy<REG>(v6);
    }

    entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<REG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<REG>(arg0, 0x2::token::transfer<REG>(0x2::token::mint<REG>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    entry fun split_and_transfer(arg0: &0x2::token::TokenPolicy<REG>, arg1: &mut 0x2::token::Token<REG>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::transfer<REG>(0x2::token::split<REG>(arg1, arg2, arg4), arg3, arg4);
        0xfa6565a38a10c30286a309188c828a95cddfef6233ae9e4ede07b9dade8ec57::denylist_rule::verify<REG>(arg0, &mut v0, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request<REG>(arg0, v0, arg4);
    }

    // decompiled from Move bytecode v6
}

