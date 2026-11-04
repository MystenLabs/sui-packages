module 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::step_up {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        threshold: u64,
        tx_digest: vector<u8>,
        spent_in_tx: u64,
    }

    public fun add<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            threshold   : arg2,
            tx_digest   : b"",
            spent_in_tx : 0,
        };
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1, arg3);
    }

    public fun config<T0>(arg0: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>) : &Config {
        let v0 = Rule{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::rule_config<T0, Rule, Config>(v0, arg0)
    }

    public fun prove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::SpendRequest, arg1: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg2: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg3: &0x2::tx_context::TxContext) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::check_is_valid(arg2);
        let v0 = *0x2::tx_context::digest(arg3);
        let v1 = Rule{dummy_field: false};
        let v2 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::rule_config_mut<T0, Rule, Config>(v1, arg1);
        if (v2.tx_digest != v0) {
            v2.tx_digest = v0;
            v2.spent_in_tx = 0;
        };
        v2.spent_in_tx = v2.spent_in_tx + 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::request_amount(arg0);
        if (v2.spent_in_tx > v2.threshold) {
            assert!(0x2::tx_context::sponsor(arg3) == 0x1::option::some<address>(0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::owner<T0>(arg1)), 1);
        };
        let v3 = Rule{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::add_receipt<T0, Rule>(v3, arg1, arg0);
    }

    public fun remove<T0>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::remove_rule<T0, Rule, Config>(arg0, arg1, arg2);
    }

    public fun threshold(arg0: &Config) : u64 {
        arg0.threshold
    }

    // decompiled from Move bytecode v7
}

