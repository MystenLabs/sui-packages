module 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::app {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun initialize(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::ActionPolicyRegistry>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::initialize(arg1));
        0x2::transfer::public_share_object<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_manager::CreditManager>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_manager::initialize(arg1));
        0x2::transfer::public_share_object<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::TierRegistry>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::initialize(arg1));
        0x2::transfer::public_share_object<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::Market>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::initialize(arg1));
        0x2::transfer::public_share_object<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::initialize(arg1));
    }

    public fun action_policy_add_input_asset<T0>(arg0: &AdminCap, arg1: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::ActionPolicyRegistry, arg2: 0x2::object::ID) {
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::policy_exists(arg1, arg2), 0);
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::add_input_asset(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::borrow_mut_policy(arg1, arg2), 0x1::type_name::get<T0>());
    }

    public fun action_policy_add_output_asset<T0>(arg0: &AdminCap, arg1: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::ActionPolicyRegistry, arg2: 0x2::object::ID) {
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::policy_exists(arg1, arg2), 0);
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::add_output_asset(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::borrow_mut_policy(arg1, arg2), 0x1::type_name::get<T0>());
    }

    public fun add_price_policy<T0, T1: drop>(arg0: &AdminCap, arg1: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry) {
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::add_price_policy<T1>(arg1, 0x1::type_name::get<T0>());
    }

    public fun add_whitelisted_action_policy_to_tier(arg0: &AdminCap, arg1: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::ActionPolicyRegistry, arg2: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::TierRegistry, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::policy_exists(arg1, arg3), 0);
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::tier_exists(arg2, arg4), 0);
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier::add_whitelisted_action(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::borrow_mut_tier(arg2, arg4), arg3);
    }

    public fun add_whitelisted_collateral_to_tier<T0>(arg0: &AdminCap, arg1: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::TierRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::tier_exists(arg1, arg2), 0);
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::risk_model::update_risk_model<T0>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier::borrow_risk_config_mut(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::borrow_mut_tier(arg1, arg2)), arg3, arg4);
    }

    public fun add_whitelisted_tier_for_pool<T0>(arg0: &AdminCap, arg1: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_manager::CreditManager, arg2: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::TierRegistry, arg3: 0x2::object::ID) {
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::tier_exists(arg2, arg3), 0);
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_manager::add_whitelisted_tier(arg1, 0x1::type_name::get<T0>(), arg3);
    }

    public fun create_action_policy<T0: drop>(arg0: &AdminCap, arg1: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::ActionPolicyRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry::add_policy(arg1, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::new<T0>(arg2));
    }

    public fun create_lending_market<T0>(arg0: &AdminCap, arg1: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::Market, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock) {
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::interest_model::add_interest_model<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::get_mut_interest_model(arg1));
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::create_pool_lp_coin<T0>(arg1, 0x2::clock::timestamp_ms(arg12) / 1000);
    }

    public fun create_tier(arg0: &AdminCap, arg1: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::TierRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::add_tier(arg1, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier::new(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

