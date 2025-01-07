module 0x30c54cc0593068a1f2a2ca7758e0e7315401adf5bf44b198683a49ee49b811e::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"BEEs", b"Engagement drops farmed per epoch via Hive-Chronicles.`", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://degenhive.ai/assets/bee_logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEE>>(v1);
        let (v3, v4) = 0x2::token::new_policy<BEE>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = &mut v6;
        set_rules<BEE>(v7, &v5, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<BEE>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<BEE>(v6);
    }

    public(friend) fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, 0x30c54cc0593068a1f2a2ca7758e0e7315401adf5bf44b198683a49ee49b811e::burn_bees::Burn>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x30c54cc0593068a1f2a2ca7758e0e7315401adf5bf44b198683a49ee49b811e::burn_bees::Burn>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x30c54cc0593068a1f2a2ca7758e0e7315401adf5bf44b198683a49ee49b811e::burn_bees::Burn>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x30c54cc0593068a1f2a2ca7758e0e7315401adf5bf44b198683a49ee49b811e::burn_bees::Burn>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x2::token::transfer_action(), 3);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x2::token::to_coin_action(), 3);
        0x30c54cc0593068a1f2a2ca7758e0e7315401adf5bf44b198683a49ee49b811e::burn_bees::set_burn_percent<T0>(arg0, arg1, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

