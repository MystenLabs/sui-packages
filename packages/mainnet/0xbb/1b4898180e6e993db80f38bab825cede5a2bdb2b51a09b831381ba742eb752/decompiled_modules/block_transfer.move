module 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::block_transfer {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        entries: vector<0x2::object::ID>,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{entries: 0x1::vector::empty<0x2::object::ID>()};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public(friend) fun add_to_blacklist<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: 0x2::object::ID) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{entries: 0x1::vector::empty<0x2::object::ID>()};
        0x1::vector::push_back<0x2::object::ID>(&mut v1.entries, arg2);
        0x1::vector::append<0x2::object::ID>(&mut v1.entries, 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).entries);
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v2, arg0, arg1, v1);
    }

    public fun allow_transfer<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::item<T0>(arg1);
        assert!(0x1::vector::contains<0x2::object::ID>(&0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).entries, &v1), 0);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v2, arg1);
    }

    // decompiled from Move bytecode v6
}

