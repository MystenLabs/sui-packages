module 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy_purchase {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        min_purchase: u64,
        max_purchase: u64,
    }

    public(friend) fun add(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Policy, arg1: u64, arg2: u64) {
        assert!(arg1 <= arg2, 200);
        let v0 = Config{
            min_purchase : arg1,
            max_purchase : arg2,
        };
        0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::add_rule<Rule, Config>(arg0, v0);
    }

    public(friend) fun check(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Policy, arg1: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Request, arg2: u64) {
        let v0 = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::rules(arg0), &v0)) {
            assert!(validate_amount_purchase(arg0, arg2), 201);
            0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::add_receipt<Rule>(arg1);
        };
    }

    public(friend) fun validate_amount_purchase(arg0: &0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Policy, arg1: u64) : bool {
        let v0 = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::get_rule<Rule, Config>(arg0);
        v0.min_purchase <= arg1 && arg1 <= v0.max_purchase
    }

    // decompiled from Move bytecode v6
}

