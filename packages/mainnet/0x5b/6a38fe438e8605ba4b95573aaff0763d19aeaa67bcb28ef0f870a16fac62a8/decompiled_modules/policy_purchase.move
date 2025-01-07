module 0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy_purchase {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        min_purchase: u64,
        max_purchase: u64,
    }

    public(friend) fun add(arg0: &mut 0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy::Policy, arg1: u64, arg2: u64) {
        assert!(arg1 <= arg2, 200);
        let v0 = Config{
            min_purchase : arg1,
            max_purchase : arg2,
        };
        0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy::add_rule<Rule, Config>(arg0, v0);
    }

    public(friend) fun check(arg0: &mut 0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy::Policy, arg1: &mut 0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy::Request, arg2: u64) {
        let v0 = 0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy::rules(arg0), &v0)) {
            assert!(validate_amount_purchase(arg0, arg2), 201);
            0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy::add_receipt<Rule>(arg1);
        };
    }

    public(friend) fun validate_amount_purchase(arg0: &0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy::Policy, arg1: u64) : bool {
        let v0 = 0x5b6a38fe438e8605ba4b95573aaff0763d19aeaa67bcb28ef0f870a16fac62a8::policy::get_rule<Rule, Config>(arg0);
        v0.min_purchase <= arg1 && arg1 <= v0.max_purchase
    }

    // decompiled from Move bytecode v6
}

