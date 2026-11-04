module 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::rate_limit {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        window_ms: u64,
        window_max: u64,
        window_start_ms: u64,
        spent_in_window: u64,
    }

    public fun add<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            window_ms       : arg2,
            window_max      : arg3,
            window_start_ms : 0,
            spent_in_window : 0,
        };
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1, arg4);
    }

    public fun prove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::SpendRequest, arg1: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg2: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg3: &0x2::clock::Clock) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::check_is_valid(arg2);
        let v0 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::request_amount(arg0);
        let v1 = Rule{dummy_field: false};
        let v2 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::rule_config_mut<T0, Rule, Config>(v1, arg1);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        if (v3 >= v2.window_start_ms + v2.window_ms) {
            v2.window_start_ms = v3;
            v2.spent_in_window = 0;
        };
        assert!(v2.spent_in_window + v0 <= v2.window_max, 1);
        v2.spent_in_window = v2.spent_in_window + v0;
        let v4 = Rule{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_receipt<T0, Rule>(v4, arg1, arg0);
    }

    public fun remove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::remove_rule<T0, Rule, Config>(arg0, arg1, arg2);
    }

    public fun spent_in_window(arg0: &Config) : u64 {
        arg0.spent_in_window
    }

    public fun view<T0>(arg0: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>) : &Config {
        let v0 = Rule{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::rule_config<T0, Rule, Config>(v0, arg0)
    }

    public fun window_max(arg0: &Config) : u64 {
        arg0.window_max
    }

    public fun window_ms(arg0: &Config) : u64 {
        arg0.window_ms
    }

    public fun window_start_ms(arg0: &Config) : u64 {
        arg0.window_start_ms
    }

    // decompiled from Move bytecode v7
}

