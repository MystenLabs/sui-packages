module 0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule {
    struct UserEntry has drop, store {
        level: u64,
        expired: u64,
    }

    struct Expired has drop {
        dummy_field: bool,
    }

    public fun add_record<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (!has_config<T0>(arg0)) {
            let v0 = Expired{dummy_field: false};
            0x2::token::add_rule_config<T0, Expired, 0x2::bag::Bag>(v0, arg0, arg1, 0x2::bag::new(arg5), arg5);
        };
        let v1 = UserEntry{
            level   : arg4,
            expired : arg3,
        };
        0x2::bag::add<address, UserEntry>(config_mut<T0>(arg0, arg1), arg2, v1);
    }

    fun config<T0>(arg0: &0x2::token::TokenPolicy<T0>) : &0x2::bag::Bag {
        let v0 = Expired{dummy_field: false};
        0x2::token::rule_config<T0, Expired, 0x2::bag::Bag>(v0, arg0)
    }

    fun config_mut<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>) : &mut 0x2::bag::Bag {
        let v0 = Expired{dummy_field: false};
        0x2::token::rule_config_mut<T0, Expired, 0x2::bag::Bag>(v0, arg0, arg1)
    }

    public fun get_user_entry<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: address) : (&UserEntry, u64, u64) {
        let v0 = 0x2::bag::borrow<address, UserEntry>(config<T0>(arg0), arg1);
        (v0, v0.level, v0.expired)
    }

    fun has_config<T0>(arg0: &0x2::token::TokenPolicy<T0>) : bool {
        0x2::token::has_rule_config_with_type<T0, Expired, 0x2::bag::Bag>(arg0)
    }

    public fun remove_record<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address) {
        0x2::bag::remove<address, UserEntry>(config_mut<T0>(arg0, arg1), arg2);
    }

    public fun update_expired<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: u64) {
        let v0 = config_mut<T0>(arg0, arg1);
        if (0x2::bag::contains<address>(v0, arg2)) {
            0x2::bag::borrow_mut<address, UserEntry>(v0, arg2).expired = arg3;
        };
    }

    public fun update_level<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: u64) {
        let v0 = config_mut<T0>(arg0, arg1);
        if (0x2::bag::contains<address>(v0, arg2)) {
            0x2::bag::borrow_mut<address, UserEntry>(v0, arg2).level = arg3;
        };
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = config<T0>(arg0);
        if (0x2::bag::contains<address>(v1, v0)) {
            assert!(0x2::bag::borrow<address, UserEntry>(v1, v0).expired == 0, 1);
            let v2 = Expired{dummy_field: false};
            0x2::token::add_approval<T0, Expired>(v2, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

