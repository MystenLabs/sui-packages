module 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy {
    struct StrategyKey has copy, drop, store {
        strategy_base_asset_type: 0x1::type_name::TypeName,
    }

    struct Strategy has copy, drop, store {
        key: StrategyKey,
        name: 0x1::string::String,
        rule_keys: vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>,
    }

    public fun add_rule_key(arg0: &mut Strategy, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&arg0.rule_keys)) {
            if (*0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&arg0.rule_keys, v0) == arg1) {
                abort 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::rule_already_exists()
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&mut arg0.rule_keys, arg1);
    }

    public fun clear_rule_keys(arg0: &mut Strategy) {
        while (!0x1::vector::is_empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&arg0.rule_keys)) {
            0x1::vector::pop_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&mut arg0.rule_keys);
        };
    }

    public fun destroy_strategy(arg0: Strategy) {
        let Strategy {
            key       : _,
            name      : _,
            rule_keys : v2,
        } = arg0;
        let v3 = v2;
        while (!0x1::vector::is_empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&v3)) {
            0x1::vector::pop_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&mut v3);
        };
        0x1::vector::destroy_empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v3);
    }

    public fun has_rule_key(arg0: &Strategy, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&arg0.rule_keys)) {
            if (*0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&arg0.rule_keys, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun key(arg0: &Strategy) : &StrategyKey {
        &arg0.key
    }

    public fun matches_base_asset_type<T0>(arg0: &StrategyKey) : bool {
        arg0.strategy_base_asset_type == 0x1::type_name::get<T0>()
    }

    public fun name(arg0: &Strategy) : &0x1::string::String {
        &arg0.name
    }

    public fun new<T0>(arg0: 0x1::string::String) : Strategy {
        Strategy{
            key       : new_strategy_key<T0>(),
            name      : arg0,
            rule_keys : 0x1::vector::empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(),
        }
    }

    public fun new_strategy_key<T0>() : StrategyKey {
        StrategyKey{strategy_base_asset_type: 0x1::type_name::get<T0>()}
    }

    public fun new_strategy_key_from_type(arg0: 0x1::type_name::TypeName) : StrategyKey {
        StrategyKey{strategy_base_asset_type: arg0}
    }

    public fun new_with_key(arg0: StrategyKey, arg1: 0x1::string::String) : Strategy {
        Strategy{
            key       : arg0,
            name      : arg1,
            rule_keys : 0x1::vector::empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(),
        }
    }

    public fun remove_rule_key(arg0: &mut Strategy, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&arg0.rule_keys)) {
            if (*0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&arg0.rule_keys, v0) == arg1) {
                0x1::vector::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&mut arg0.rule_keys, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::rule_not_found()
    }

    public fun rule_keys(arg0: &Strategy) : &vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey> {
        &arg0.rule_keys
    }

    public fun strategy_base_asset_type(arg0: &StrategyKey) : &0x1::type_name::TypeName {
        &arg0.strategy_base_asset_type
    }

    // decompiled from Move bytecode v6
}

