module 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::actions {
    public fun add_input_asset<T0: store>(arg0: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::OwnerKey, arg2: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::ActionReceipt) {
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::assert_owner(arg0, arg1);
        assert_ca(arg0, arg2);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::add_input_asset<T0>(arg2, 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::pop_asset<T0>(arg0));
    }

    public fun pop_output_asset<T0: store>(arg0: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::OwnerKey, arg2: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::ActionReceipt) {
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::assert_owner(arg0, arg1);
        assert_ca(arg0, arg2);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::add_asset<T0>(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::pop_output_asset<T0>(arg2), arg0);
    }

    fun assert_ca(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::ActionReceipt) {
        let (v0, _) = 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::for(arg1);
        assert!(0x2::object::id<0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount>(arg0) == v0, 0);
    }

    public fun get_action_receipt(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::OwnerKey, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy_registry::ActionPolicyRegistry, arg3: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry, arg4: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) : 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::ActionReceipt {
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::assert_owner(arg0, arg1);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy_registry::policy_exists(arg2, arg5);
        assert!(!0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::account_value::is_unhealthy(arg0, arg4, arg3), 0);
        assert!(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier::is_whitelisted_action(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::borrow_tier(arg3, 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::tier_id(arg0)), arg5), 0);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::new(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy_registry::borrow_policy(arg2, arg5), 0x2::object::id<0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount>(arg0), arg6)
    }

    public fun process_action_receipt(arg0: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::OwnerKey, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry, arg3: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg4: 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::ActionReceipt) {
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::assert_owner(arg0, arg1);
        assert_ca(arg0, &arg4);
        assert!(!0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::account_value::is_unhealthy(arg0, arg3, arg2), 0);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt::burn(arg4);
    }

    // decompiled from Move bytecode v6
}

