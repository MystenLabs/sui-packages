module 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        permanent: bool,
    }

    public fun add(arg0: &mut 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, arg1: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicyCap, arg2: bool) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{permanent: arg2};
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun execute_remove(arg0: &mut 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, arg1: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicyCap, arg2: &0x2::tx_context::TxContext) : Config {
        let v0 = Rule{dummy_field: false};
        assert!(!0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::get_rule<Rule, Config>(v0, arg0).permanent, 1);
        let v1 = Rule{dummy_field: false};
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::execute_remove_rule<Rule, Config>(arg0, arg1, v1, arg2)
    }

    public fun is_permanent(arg0: &Config) : bool {
        arg0.permanent
    }

    public fun propose_remove(arg0: &mut 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, arg1: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicyCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        assert!(!0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::get_rule<Rule, Config>(v0, arg0).permanent, 1);
        let v1 = Rule{dummy_field: false};
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::propose_remove_rule<Rule>(arg0, arg1, v1, arg2);
    }

    public fun prove(arg0: &mut 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningRequest, arg1: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, arg2: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::umi_signer::UmiSigner, arg3: vector<u8>) {
        let v0 = 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::umi_signer::new_chain_id(arg3);
        assert!(0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::umi_signer::has_wallet(arg2, v0) && 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::umi_signer::is_locked(arg2, v0), 0);
        let v1 = Rule{dummy_field: false};
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::add_receipt<Rule>(v1, arg0);
    }

    public fun remove(arg0: &mut 0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicy, arg1: &0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::SigningPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        assert!(!0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::get_rule<Rule, Config>(v0, arg0).permanent, 1);
        let v1 = Rule{dummy_field: false};
        0x7c3e40c1147cb1aee5c3c1a9b0b045395ffd5e23cecfea2cc0f5da6423455f87::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v1)
    }

    // decompiled from Move bytecode v6
}

