module 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::timelock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        delay_secs: u64,
    }

    public fun add(arg0: &mut 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicy, arg1: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicyCap, arg2: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{delay_secs: arg2};
        0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::add_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun delay_secs(arg0: &Config) : u64 {
        arg0.delay_secs
    }

    public fun prove(arg0: &mut 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningRequest, arg1: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicy, arg2: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::tx_context::epoch_timestamp_ms(arg2) >= 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::created_at(arg0) + 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::get_rule<Rule, Config>(v0, arg1).delay_secs * 1000, 0);
        let v1 = Rule{dummy_field: false};
        0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::add_receipt<Rule>(v1, arg0);
    }

    // decompiled from Move bytecode v6
}

