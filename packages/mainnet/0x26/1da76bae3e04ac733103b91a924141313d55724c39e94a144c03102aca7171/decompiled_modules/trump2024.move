module 0x261da76bae3e04ac733103b91a924141313d55724c39e94a144c03102aca7171::trump2024 {
    struct TRUMP2024 has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, b"T2RUMP2024", b"President Trump", b"the USA President Trump", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: TRUMP2024, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<TRUMP2024>(arg0, arg1);
        let (v1, v2) = 0x2::token::new_policy<TRUMP2024>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        set_rules<TRUMP2024>(v5, &v3, arg1);
        0x2::coin::mint_and_transfer<TRUMP2024>(&mut v0, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP2024>>(v0);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<TRUMP2024>>(v3, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<TRUMP2024>(v4);
    }

    public(friend) fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, 0x261da76bae3e04ac733103b91a924141313d55724c39e94a144c03102aca7171::allowlist_rule::Allowlist>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x261da76bae3e04ac733103b91a924141313d55724c39e94a144c03102aca7171::allowlist_rule::Allowlist>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x261da76bae3e04ac733103b91a924141313d55724c39e94a144c03102aca7171::allowlist_rule::Allowlist>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x261da76bae3e04ac733103b91a924141313d55724c39e94a144c03102aca7171::allowlist_rule::Allowlist>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
    }

    public fun swap_buy(arg0: &mut 0x2::token::TokenPolicy<TRUMP2024>, arg1: &mut 0x2::token::TokenPolicyCap<TRUMP2024>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x261da76bae3e04ac733103b91a924141313d55724c39e94a144c03102aca7171::allowlist_rule::add_records<TRUMP2024>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::token::TokenPolicy<TRUMP2024>, arg1: &mut 0x2::token::TokenPolicyCap<TRUMP2024>, arg2: vector<address>) {
        0x261da76bae3e04ac733103b91a924141313d55724c39e94a144c03102aca7171::allowlist_rule::remove_records<TRUMP2024>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

