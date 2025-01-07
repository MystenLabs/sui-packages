module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::app {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun initialize(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::ActionPolicyRegistry>(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::initialize(arg1));
        0x2::transfer::public_share_object<0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_manager::CreditManager>(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_manager::initialize(arg1));
        0x2::transfer::public_share_object<0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::TierRegistry>(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::initialize(arg1));
        0x2::transfer::public_share_object<0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::Market>(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::initialize(arg1));
        0x2::transfer::public_share_object<0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::price_policy::PricePolicyRegistry>(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::price_policy::initialize(arg1));
    }

    public fun action_policy_add_input_asset<T0>(arg0: &AdminCap, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::ActionPolicyRegistry, arg2: 0x2::object::ID) {
        assert!(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::policy_exists(arg1, arg2), 0);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy::add_input_asset(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::borrow_mut_policy(arg1, arg2), 0x1::type_name::get<T0>());
    }

    public fun action_policy_add_output_asset<T0>(arg0: &AdminCap, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::ActionPolicyRegistry, arg2: 0x2::object::ID) {
        assert!(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::policy_exists(arg1, arg2), 0);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy::add_output_asset(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::borrow_mut_policy(arg1, arg2), 0x1::type_name::get<T0>());
    }

    public fun add_price_policy<T0, T1: drop>(arg0: &AdminCap, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::price_policy::PricePolicyRegistry) {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::price_policy::add_price_policy<T1>(arg1, 0x1::type_name::get<T0>());
    }

    public fun add_whitelisted_action_policy_to_tier(arg0: &AdminCap, arg1: &0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::ActionPolicyRegistry, arg2: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::TierRegistry, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        assert!(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::policy_exists(arg1, arg3), 0);
        assert!(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::tier_exists(arg2, arg4), 0);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::add_whitelisted_action(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::borrow_mut_tier(arg2, arg4), arg3);
    }

    public fun add_whitelisted_collateral_to_tier<T0>(arg0: &AdminCap, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::TierRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        assert!(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::tier_exists(arg1, arg2), 0);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::risk_model::update_risk_model<T0>(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::borrow_risk_config_mut(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::borrow_mut_tier(arg1, arg2)), arg3, arg4);
    }

    public fun add_whitelisted_tier_for_pool<T0>(arg0: &AdminCap, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_manager::CreditManager, arg2: &0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::TierRegistry, arg3: 0x2::object::ID) {
        assert!(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::tier_exists(arg2, arg3), 0);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_manager::add_whitelisted_tier(arg1, 0x1::type_name::get<T0>(), arg3);
    }

    public fun create_action_policy<T0: drop>(arg0: &AdminCap, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::ActionPolicyRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy_registry::add_policy(arg1, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::action_policy::new<T0>(arg2));
    }

    public fun create_lending_market<T0>(arg0: &AdminCap, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::Market, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock) {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::interest_model::add_interest_model<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::get_mut_interest_model(arg1));
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::create_pool_lp_coin<T0>(arg1, 0x2::clock::timestamp_ms(arg12) / 1000);
    }

    public fun create_tier(arg0: &AdminCap, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::TierRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::add_tier(arg1, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::new(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AdminCap>(v0);
    }

    // decompiled from Move bytecode v6
}

