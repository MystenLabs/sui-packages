module 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy_whitelist {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        whitelist: 0x2::vec_set::VecSet<address>,
    }

    public(friend) fun add(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy, arg1: vector<address>) {
        let v0 = 0x2::vec_set::empty<address>();
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::vec_set::insert<address>(&mut v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v1 = Config{whitelist: v0};
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::add_rule<Rule, Config>(arg0, v1);
    }

    public(friend) fun check(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy, arg1: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Request, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::rules(arg0), &v0)) {
            let v1 = 0x2::tx_context::sender(arg2);
            assert!(check_in_whitelist(arg0, &v1), 1100);
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::add_receipt<Rule>(arg1);
        };
    }

    public fun check_in_whitelist(arg0: &0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy, arg1: &address) : bool {
        0x2::vec_set::contains<address>(&0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::get_rule<Rule, Config>(arg0).whitelist, arg1)
    }

    public(friend) fun clear_whitelist(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy) {
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::get_rule_mut<Rule, Config>(arg0).whitelist = 0x2::vec_set::empty<address>();
    }

    public(friend) fun pass(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy, arg1: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Request) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Rule>();
        if (0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::rules(arg0), &v0)) {
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::add_receipt<Rule>(arg1);
        };
    }

    public(friend) fun remove_whitelist(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy, arg1: vector<address>) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::get_rule_mut<Rule, Config>(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::vec_set::contains<address>(&v0.whitelist, &v1)) {
                0x2::vec_set::remove<address>(&mut v0.whitelist, &v1);
            };
        };
    }

    public(friend) fun set_whitelist(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::Policy, arg1: vector<address>) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::policy::get_rule_mut<Rule, Config>(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::vec_set::contains<address>(&v0.whitelist, &v1)) {
                0x2::vec_set::insert<address>(&mut v0.whitelist, v1);
            };
        };
    }

    // decompiled from Move bytecode v6
}

