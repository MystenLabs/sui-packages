module 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy {
    struct StrategyKey has copy, drop, store {
        strategy_name: 0x1::string::String,
    }

    struct Strategy has copy, drop, store {
        key: StrategyKey,
        name: 0x1::string::String,
        policy_keys: vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>,
        base_asset_types: vector<0x1::type_name::TypeName>,
    }

    public(friend) fun add_policy_key(arg0: &mut Strategy, arg1: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_keys)) {
            if (*0x1::vector::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_keys, v0) == arg1) {
                abort 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::rule_already_exists()
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&mut arg0.policy_keys, arg1);
    }

    public fun base_asset_types(arg0: &Strategy) : &vector<0x1::type_name::TypeName> {
        &arg0.base_asset_types
    }

    public(friend) fun clear_policy_keys(arg0: &mut Strategy) {
        while (!0x1::vector::is_empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_keys)) {
            0x1::vector::pop_back<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&mut arg0.policy_keys);
        };
    }

    public(friend) fun destroy_strategy(arg0: Strategy) {
        let Strategy {
            key              : _,
            name             : _,
            policy_keys      : v2,
            base_asset_types : v3,
        } = arg0;
        let v4 = v3;
        let v5 = v2;
        while (!0x1::vector::is_empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&v5)) {
            0x1::vector::pop_back<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&mut v5);
        };
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v4)) {
            0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4);
        };
        0x1::vector::destroy_empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(v5);
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v4);
    }

    public fun has_policy_key(arg0: &Strategy, arg1: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_keys)) {
            if (*0x1::vector::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_keys, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun key(arg0: &Strategy) : &StrategyKey {
        &arg0.key
    }

    public fun name(arg0: &Strategy) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: vector<0x1::type_name::TypeName>) : Strategy {
        Strategy{
            key              : new_strategy_key(arg0),
            name             : arg0,
            policy_keys      : 0x1::vector::empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(),
            base_asset_types : arg1,
        }
    }

    public(friend) fun new_strategy_key(arg0: 0x1::string::String) : StrategyKey {
        StrategyKey{strategy_name: arg0}
    }

    public(friend) fun new_with_key(arg0: StrategyKey, arg1: 0x1::string::String, arg2: vector<0x1::type_name::TypeName>) : Strategy {
        Strategy{
            key              : arg0,
            name             : arg1,
            policy_keys      : 0x1::vector::empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(),
            base_asset_types : arg2,
        }
    }

    public fun policy_keys(arg0: &Strategy) : &vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey> {
        &arg0.policy_keys
    }

    public(friend) fun remove_policy_key(arg0: &mut Strategy, arg1: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_keys)) {
            if (*0x1::vector::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_keys, v0) == arg1) {
                0x1::vector::remove<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&mut arg0.policy_keys, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::rule_not_found()
    }

    public fun strategy_name(arg0: &StrategyKey) : &0x1::string::String {
        &arg0.strategy_name
    }

    public fun supports_asset_type<T0>(arg0: &Strategy) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.base_asset_types)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.base_asset_types, v0) == 0x1::type_name::with_defining_ids<T0>()) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

