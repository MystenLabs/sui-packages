module 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::timelock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        delay_secs: u64,
    }

    public fun add(arg0: &mut 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicy, arg1: &0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicyCap, arg2: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{delay_secs: arg2};
        0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun delay_secs(arg0: &Config) : u64 {
        arg0.delay_secs
    }

    public fun prove(arg0: &mut 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningRequest, arg1: &0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::SigningPolicy, arg2: &0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::umi_signer::UmiSigner, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::umi_signer::last_owner_activity_ts(arg2) + 0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::get_rule<Rule, Config>(v0, arg1).delay_secs * 1000, 0);
        let v1 = Rule{dummy_field: false};
        0x4dd25dc8e36e11f8ccd2cea276f6afdc44a9845d11cbfd8ae3aa6e606e5e876f::signing_policy::add_receipt<Rule>(v1, arg0);
    }

    // decompiled from Move bytecode v6
}

