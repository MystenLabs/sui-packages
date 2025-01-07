module 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_receipt {
    struct ActionReceipt {
        for_ca: 0x2::object::ID,
        for_policy: 0x2::object::ID,
        input_assets: 0x2::bag::Bag,
        output_assets: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::ActionPolicy, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : ActionReceipt {
        ActionReceipt{
            for_ca        : arg1,
            for_policy    : 0x2::object::id<0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::ActionPolicy>(arg0),
            input_assets  : 0x2::bag::new(arg2),
            output_assets : 0x2::bag::new(arg2),
        }
    }

    public(friend) fun add_input_asset<T0: store>(arg0: &mut ActionReceipt, arg1: T0) {
        0x2::bag::add<0x1::type_name::TypeName, T0>(&mut arg0.input_assets, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun add_output_asset<T0: store, T1: drop>(arg0: T1, arg1: &mut ActionReceipt, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::ActionPolicy, arg3: T0) {
        assert!(0x2::object::id<0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::ActionPolicy>(arg2) == arg1.for_policy, 0);
        assert!(0x1::type_name::get<T1>() == 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::rule(arg2), 0);
        assert!(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::is_output_asset(arg2, 0x1::type_name::get<T0>()), 0);
        0x2::bag::add<0x1::type_name::TypeName, T0>(&mut arg1.output_assets, 0x1::type_name::get<T0>(), arg3);
    }

    public(friend) fun burn(arg0: ActionReceipt) {
        let ActionReceipt {
            for_ca        : _,
            for_policy    : _,
            input_assets  : v2,
            output_assets : v3,
        } = arg0;
        0x2::bag::destroy_empty(v2);
        0x2::bag::destroy_empty(v3);
    }

    public fun for(arg0: &ActionReceipt) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.for_ca, arg0.for_policy)
    }

    public fun pop_input_asset<T0: store, T1: drop>(arg0: T1, arg1: &mut ActionReceipt, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::ActionPolicy) : T0 {
        assert!(0x2::object::id<0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::ActionPolicy>(arg2) == arg1.for_policy, 0);
        assert!(0x1::type_name::get<T1>() == 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::action_policy::rule(arg2), 0);
        0x2::bag::remove<0x1::type_name::TypeName, T0>(&mut arg1.input_assets, 0x1::type_name::get<T0>())
    }

    public fun pop_output_asset<T0: store>(arg0: &mut ActionReceipt) : T0 {
        0x2::bag::remove<0x1::type_name::TypeName, T0>(&mut arg0.input_assets, 0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

