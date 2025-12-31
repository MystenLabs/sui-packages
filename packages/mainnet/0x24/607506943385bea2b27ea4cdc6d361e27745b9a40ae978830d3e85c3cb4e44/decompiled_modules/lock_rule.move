module 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        permanent: bool,
    }

    public fun add(arg0: &mut 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicy, arg1: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicyCap, arg2: bool) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{permanent: arg2};
        0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::add_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun is_permanent(arg0: &Config) : bool {
        arg0.permanent
    }

    public fun prove(arg0: &mut 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningRequest, arg1: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::SigningPolicy, arg2: &0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::UmiSigner, arg3: vector<u8>) {
        let v0 = 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::new_chain_id(arg3);
        assert!(0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::has_wallet(arg2, v0) && 0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::umi_signer::is_locked(arg2, v0), 0);
        let v1 = Rule{dummy_field: false};
        0x24607506943385bea2b27ea4cdc6d361e27745b9a40ae978830d3e85c3cb4e44::signing_policy::add_receipt<Rule>(v1, arg0);
    }

    // decompiled from Move bytecode v6
}

