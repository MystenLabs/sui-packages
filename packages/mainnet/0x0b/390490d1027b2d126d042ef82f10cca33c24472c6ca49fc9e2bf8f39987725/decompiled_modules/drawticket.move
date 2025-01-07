module 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::drawticket {
    struct DRAWTICKET has drop {
        dummy_field: bool,
    }

    public fun add_admin<T0>(arg0: &mut 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::add_capability<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::AdminCap>(arg0, arg1, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::new_admin_cap(), arg2);
    }

    public fun add_burner<T0>(arg0: &mut 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::add_capability<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::BurnCap>(arg0, arg1, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::new_burn_cap(), arg2);
    }

    public fun add_minter<T0>(arg0: &mut 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::add_capability<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::MintCap>(arg0, arg1, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::new_mint_cap(5000000, arg2), arg2);
    }

    public fun burn<T0>(arg0: &mut 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::ControlledTreasury<T0>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::burn<T0>(arg0, arg1, arg2);
    }

    fun init(arg0: DRAWTICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAWTICKET>(arg0, 0, b"DRT", b"Xociety Draw Ticket", b"Draw Ticket Token for Xociety ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.xociety.io/assets/xcs/xcs-ticket.png"))), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<DRAWTICKET>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::new<DRAWTICKET>(v2, 0x2::tx_context::sender(arg1), arg1);
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::add_capability<DRAWTICKET, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::MintCap>(&mut v7, @0x3142efe76da5935d46bcbde9351398e6b70fa8423a86c98e39ad71c24bdb95c7, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::new_mint_cap(5000000, arg1), arg1);
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::add_capability<DRAWTICKET, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::WhitelistCap>(&mut v7, @0x3142efe76da5935d46bcbde9351398e6b70fa8423a86c98e39ad71c24bdb95c7, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::new_whitelist_cap(), arg1);
        let v8 = &mut v6;
        set_rules<DRAWTICKET>(v8, &v5, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAWTICKET>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<DRAWTICKET>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<DRAWTICKET>(v6);
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::share<DRAWTICKET>(v7);
    }

    public fun mint<T0>(arg0: &mut 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::mint_and_transfer<T0>(arg0, 1, arg1, arg2);
    }

    public fun remove_admin<T0>(arg0: &mut 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::remove_capability<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::AdminCap>(arg0, arg1, arg2);
    }

    public fun remove_burner<T0>(arg0: &mut 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::remove_capability<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::BurnCap>(arg0, arg1, arg2);
    }

    public fun remove_minter<T0>(arg0: &mut 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::remove_capability<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::treasury::MintCap>(arg0, arg1, arg2);
    }

    public(friend) fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::denylist_rule::Denylist>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::denylist_rule::Denylist>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::denylist_rule::Denylist>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0xb390490d1027b2d126d042ef82f10cca33c24472c6ca49fc9e2bf8f39987725::denylist_rule::Denylist>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
    }

    // decompiled from Move bytecode v6
}

