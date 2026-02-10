module 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy {
    struct StrategyKey has copy, drop, store {
        strategy_name: 0x1::string::String,
    }

    struct Strategy has copy, drop, store {
        key: StrategyKey,
        name: 0x1::string::String,
        policy_keys: vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>,
        base_asset_types: vector<0x1::type_name::TypeName>,
        sheet_type: 0x1::type_name::TypeName,
    }

    public(friend) fun add_policy_key(arg0: &mut Strategy, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&arg0.policy_keys)) {
            if (*0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&arg0.policy_keys, v0) == arg1) {
                abort 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::rule_already_exists()
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&mut arg0.policy_keys, arg1);
    }

    public fun assert_sheet_type<T0>(arg0: &Strategy) {
        assert!(arg0.sheet_type == 0x1::type_name::with_defining_ids<T0>(), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::invalid_sheet_type_for_strategy());
    }

    public fun base_asset_types(arg0: &Strategy) : &vector<0x1::type_name::TypeName> {
        &arg0.base_asset_types
    }

    public(friend) fun clear_policy_keys(arg0: &mut Strategy) {
        while (!0x1::vector::is_empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&arg0.policy_keys)) {
            0x1::vector::pop_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&mut arg0.policy_keys);
        };
    }

    public(friend) fun destroy_strategy(arg0: Strategy) {
        let Strategy {
            key              : _,
            name             : _,
            policy_keys      : v2,
            base_asset_types : v3,
            sheet_type       : _,
        } = arg0;
        let v5 = v3;
        let v6 = v2;
        while (!0x1::vector::is_empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&v6)) {
            0x1::vector::pop_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&mut v6);
        };
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v5)) {
            0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5);
        };
        0x1::vector::destroy_empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(v6);
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v5);
    }

    public fun has_policy_key(arg0: &Strategy, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&arg0.policy_keys)) {
            if (*0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&arg0.policy_keys, v0) == arg1) {
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

    public(friend) fun new(arg0: 0x1::string::String, arg1: vector<0x1::type_name::TypeName>, arg2: 0x1::type_name::TypeName) : Strategy {
        Strategy{
            key              : new_strategy_key(arg0),
            name             : arg0,
            policy_keys      : 0x1::vector::empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(),
            base_asset_types : arg1,
            sheet_type       : arg2,
        }
    }

    public(friend) fun new_strategy_key(arg0: 0x1::string::String) : StrategyKey {
        StrategyKey{strategy_name: arg0}
    }

    public(friend) fun new_with_key(arg0: StrategyKey, arg1: 0x1::string::String, arg2: vector<0x1::type_name::TypeName>, arg3: 0x1::type_name::TypeName) : Strategy {
        Strategy{
            key              : arg0,
            name             : arg1,
            policy_keys      : 0x1::vector::empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(),
            base_asset_types : arg2,
            sheet_type       : arg3,
        }
    }

    public fun policy_keys(arg0: &Strategy) : &vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey> {
        &arg0.policy_keys
    }

    public(friend) fun remove_policy_key(arg0: &mut Strategy, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&arg0.policy_keys)) {
            if (*0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&arg0.policy_keys, v0) == arg1) {
                0x1::vector::remove<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(&mut arg0.policy_keys, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::rule_not_found()
    }

    public fun sheet_type(arg0: &Strategy) : 0x1::type_name::TypeName {
        arg0.sheet_type
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

