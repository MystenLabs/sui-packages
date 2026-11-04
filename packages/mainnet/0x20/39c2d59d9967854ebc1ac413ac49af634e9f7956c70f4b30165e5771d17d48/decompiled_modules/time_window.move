module 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::time_window {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        not_before_ms: u64,
        not_after_ms: u64,
    }

    public fun add<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 < arg3, 2);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            not_before_ms : arg2,
            not_after_ms  : arg3,
        };
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1, arg4);
    }

    public fun not_after_ms(arg0: &Config) : u64 {
        arg0.not_after_ms
    }

    public fun not_before_ms(arg0: &Config) : u64 {
        arg0.not_before_ms
    }

    public fun prove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::SpendRequest, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg2: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg3: &0x2::clock::Clock) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::check_is_valid(arg2);
        let v0 = Rule{dummy_field: false};
        let v1 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::rule_config<T0, Rule, Config>(v0, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= v1.not_before_ms && v2 < v1.not_after_ms, 1);
        let v3 = Rule{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_receipt<T0, Rule>(v3, arg1, arg0);
    }

    public fun remove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::remove_rule<T0, Rule, Config>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

