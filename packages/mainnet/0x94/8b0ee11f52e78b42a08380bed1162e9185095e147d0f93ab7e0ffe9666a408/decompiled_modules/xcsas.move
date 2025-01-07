module 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsas {
    struct XCSAS has drop {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::burn<T0>(arg0, arg1, arg2);
    }

    public fun add_admin<T0>(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::add_capability<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::AdminCap>(arg0, arg1, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::new_admin_cap(), arg2);
    }

    public fun add_burner<T0>(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::add_capability<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::BurnCap>(arg0, arg1, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::new_burn_cap(), arg2);
    }

    public fun add_minter<T0>(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::add_capability<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::MintCap>(arg0, arg1, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::new_mint_cap(5000000, arg2), arg2);
    }

    public fun getCurrentSupply<T0>(arg0: &0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::balance::supply_value<T0>(0x2::coin::supply_immut<T0>(0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::get_treasury_cap_immut<T0>(arg0)))
    }

    fun init(arg0: XCSAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCSAS>(arg0, 0, b"XCSAS", b"Xociety company stock - Arena Star", b"Stock for the Xociety in-game company named Arena Star", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.xociety.io/assets/xcs/xcsas.png"))), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<XCSAS>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::new<XCSAS>(v2, 0x2::tx_context::sender(arg1), arg1);
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::add_capability<XCSAS, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::MintCap>(&mut v7, 0x2::tx_context::sender(arg1), 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::new_mint_cap(5000000, arg1), arg1);
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::add_capability<XCSAS, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::WhitelistCap>(&mut v7, 0x2::tx_context::sender(arg1), 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::new_whitelist_cap(), arg1);
        let v8 = &mut v6;
        set_rules<XCSAS>(v8, &v5, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCSAS>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<XCSAS>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<XCSAS>(v6);
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::share<XCSAS>(v7);
    }

    public fun mint<T0>(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    public fun remove_admin<T0>(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::remove_capability<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::AdminCap>(arg0, arg1, arg2);
    }

    public fun remove_burner<T0>(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::remove_capability<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::BurnCap>(arg0, arg1, arg2);
    }

    public fun remove_minter<T0>(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::remove_capability<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::MintCap>(arg0, arg1, arg2);
    }

    public(friend) fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::denylist_rule::Denylist>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::denylist_rule::Denylist>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::denylist_rule::Denylist>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::denylist_rule::Denylist>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
    }

    // decompiled from Move bytecode v6
}

