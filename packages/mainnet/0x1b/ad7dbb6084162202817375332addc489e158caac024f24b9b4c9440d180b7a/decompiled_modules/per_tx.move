module 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::per_tx {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        max_mist: u64,
        tx_digest: vector<u8>,
        spent_in_tx: u64,
    }

    public fun add<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            max_mist    : arg2,
            tx_digest   : b"",
            spent_in_tx : 0,
        };
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1, arg3);
    }

    public fun max_mist(arg0: &Config) : u64 {
        arg0.max_mist
    }

    public fun prove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::SpendRequest, arg1: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg2: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg3: &0x2::tx_context::TxContext) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::check_is_valid(arg2);
        let v0 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::request_amount(arg0);
        let v1 = *0x2::tx_context::digest(arg3);
        let v2 = Rule{dummy_field: false};
        let v3 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::rule_config_mut<T0, Rule, Config>(v2, arg1);
        if (v3.tx_digest != v1) {
            v3.tx_digest = v1;
            v3.spent_in_tx = 0;
        };
        assert!(v0 <= v3.max_mist, 1);
        assert!(v3.spent_in_tx <= v3.max_mist - v0, 1);
        v3.spent_in_tx = v3.spent_in_tx + v0;
        let v4 = Rule{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_receipt<T0, Rule>(v4, arg1, arg0);
    }

    public fun remove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::remove_rule<T0, Rule, Config>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

