module 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::spend_limit_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        version: u64,
    }

    struct CoinLimitKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct CoinLimit has drop, store {
        per_spend: 0x1::option::Option<u64>,
        window_ms: u64,
        window_limit: 0x1::option::Option<u64>,
    }

    struct SpendKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct SpendWindow has drop, store {
        window_start_ms: u64,
        total: u64,
    }

    public fun add(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{version: 1};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun remove(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 5);
    }

    public fun migrate(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::get_rule_mut_for_migration<Rule, Config>(v0, arg0);
        if (v1.version < 1) {
            v1.version = 1;
        };
    }

    public fun prove(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy>(arg1) == 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::policy_id(arg2), 3);
        assert!(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::signer_id(arg0) == 0x2::object::id<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner>(arg2), 3);
        let v0 = Rule{dummy_field: false};
        assert_version(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::get_rule<Rule, Config>(v0, arg1));
        let v1 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::coin(arg0);
        let v2 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::amount(arg0);
        let v3 = CoinLimitKey{coin: v1};
        let v4 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::uid(arg1);
        assert!(0x2::dynamic_field::exists<CoinLimitKey>(v4, v3), 2);
        let v5 = 0x2::dynamic_field::borrow<CoinLimitKey, CoinLimit>(v4, v3);
        if (0x1::option::is_some<u64>(&v5.per_spend)) {
            assert!(v2 <= *0x1::option::borrow<u64>(&v5.per_spend), 0);
        };
        if (0x1::option::is_some<u64>(&v5.window_limit)) {
            let v6 = 0x2::clock::timestamp_ms(arg3);
            let v7 = SpendKey{coin: v1};
            let v8 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::uid_mut(arg2);
            if (0x2::dynamic_field::exists<SpendKey>(v8, v7)) {
                let v9 = 0x2::dynamic_field::borrow_mut<SpendKey, SpendWindow>(v8, v7);
                if (v6 - v9.window_start_ms >= v5.window_ms) {
                    v9.window_start_ms = v6;
                    v9.total = v2;
                } else {
                    v9.total = v9.total + v2;
                };
                assert!(v9.total <= *0x1::option::borrow<u64>(&v5.window_limit), 1);
            } else {
                assert!(v2 <= *0x1::option::borrow<u64>(&v5.window_limit), 1);
                let v10 = SpendWindow{
                    window_start_ms : v6,
                    total           : v2,
                };
                0x2::dynamic_field::add<SpendKey, SpendWindow>(v8, v7, v10);
            };
        };
        let v11 = Rule{dummy_field: false};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::add_receipt<Rule>(v11, arg1, arg0);
    }

    public fun remove_limit<T0>(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = CoinLimitKey{coin: 0x1::type_name::with_original_ids<T0>()};
        let v2 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::policy_uid_mut(arg0);
        if (0x2::dynamic_field::exists<CoinLimitKey>(v2, v1)) {
            0x2::dynamic_field::remove<CoinLimitKey, CoinLimit>(v2, v1);
        };
    }

    public fun set_limit<T0>(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: 0x1::option::Option<u64>) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        assert!(0x1::option::is_some<u64>(&arg2) || 0x1::option::is_some<u64>(&arg4), 4);
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(arg3 > 0, 4);
        };
        let v1 = CoinLimitKey{coin: 0x1::type_name::with_original_ids<T0>()};
        let v2 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::policy_uid_mut(arg0);
        if (0x2::dynamic_field::exists<CoinLimitKey>(v2, v1)) {
            0x2::dynamic_field::remove<CoinLimitKey, CoinLimit>(v2, v1);
        };
        let v3 = CoinLimit{
            per_spend    : arg2,
            window_ms    : arg3,
            window_limit : arg4,
        };
        0x2::dynamic_field::add<CoinLimitKey, CoinLimit>(v2, v1, v3);
    }

    public fun spent_in_window<T0>(arg0: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: u64, arg2: u64) : u64 {
        let v0 = SpendKey{coin: 0x1::type_name::with_original_ids<T0>()};
        let v1 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::uid(arg0);
        if (!0x2::dynamic_field::exists<SpendKey>(v1, v0)) {
            return 0
        };
        let v2 = 0x2::dynamic_field::borrow<SpendKey, SpendWindow>(v1, v0);
        if (arg2 - v2.window_start_ms >= arg1) {
            0
        } else {
            v2.total
        }
    }

    // decompiled from Move bytecode v7
}

