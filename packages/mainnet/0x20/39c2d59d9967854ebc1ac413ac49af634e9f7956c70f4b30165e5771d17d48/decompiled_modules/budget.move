module 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::budget {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        total_mist: u64,
        spent: u64,
    }

    public fun spent(arg0: &Config) : u64 {
        arg0.spent
    }

    public fun add<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            total_mist : arg2,
            spent      : 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::spent<T0>(arg0),
        };
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1, arg3);
    }

    public fun prove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::SpendRequest, arg1: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg2: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::check_is_valid(arg2);
        let v0 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::request_amount(arg0);
        let v1 = Rule{dummy_field: false};
        let v2 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::rule_config_mut<T0, Rule, Config>(v1, arg1);
        assert!(v2.spent + v0 <= v2.total_mist, 1);
        v2.spent = v2.spent + v0;
        let v3 = Rule{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_receipt<T0, Rule>(v3, arg1, arg0);
    }

    public fun remove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::remove_rule<T0, Rule, Config>(arg0, arg1, arg2);
    }

    public fun total_mist(arg0: &Config) : u64 {
        arg0.total_mist
    }

    // decompiled from Move bytecode v7
}

