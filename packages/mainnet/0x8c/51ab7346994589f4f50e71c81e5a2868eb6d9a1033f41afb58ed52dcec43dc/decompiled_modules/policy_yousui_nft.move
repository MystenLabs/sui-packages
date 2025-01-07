module 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy_yousui_nft {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public(friend) fun add(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Policy) {
        let v0 = Config{dummy_field: false};
        0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::add_rule<Rule, Config>(arg0, v0);
    }

    public(friend) fun check(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Policy, arg1: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Request, arg2: &0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::YOUSUINFT) {
        let v0 = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::rules(arg0), &v0)) {
            assert!(check_yousui_nft(arg2), 1000);
            0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::add_receipt<Rule>(arg1);
        };
    }

    public(friend) fun check_tier(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Policy, arg1: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Request, arg2: &0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::YOUSUINFT) {
        let v0 = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::rules(arg0), &v0)) {
            assert!(check_yousui_nft_tier(arg2), 1000);
            0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::add_receipt<Rule>(arg1);
        };
    }

    fun check_yousui_nft(arg0: &0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::YOUSUINFT) : bool {
        0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::type(arg0) == b"og"
    }

    fun check_yousui_nft_tier(arg0: &0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::YOUSUINFT) : bool {
        let v0 = 0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::type(arg0);
        v0 == b"4" || v0 == b"5"
    }

    public(friend) fun pass(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Policy, arg1: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::Request) {
        let v0 = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::rules(arg0), &v0)) {
            0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::policy::add_receipt<Rule>(arg1);
        };
    }

    // decompiled from Move bytecode v6
}

