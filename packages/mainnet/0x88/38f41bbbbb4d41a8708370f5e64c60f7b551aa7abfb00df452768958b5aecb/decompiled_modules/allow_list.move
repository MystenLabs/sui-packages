module 0x8838f41bbbbb4d41a8708370f5e64c60f7b551aa7abfb00df452768958b5aecb::allow_list {
    struct AllowList has drop {
        dummy_field: bool,
    }

    struct AllowListConfig has store {
        allowed: vector<address>,
    }

    public fun allowed_add<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AllowList{dummy_field: false};
        0x1::vector::push_back<address>(&mut 0x2::token::rule_config_mut<T0, AllowList, AllowListConfig>(v0, arg1, arg0).allowed, arg2);
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AllowList{dummy_field: false};
        let v1 = 0x2::tx_context::sender(arg2);
        if (0x1::vector::contains<address>(&0x2::token::rule_config<T0, AllowList, AllowListConfig>(v0, arg0).allowed, &v1)) {
            let v2 = AllowList{dummy_field: false};
            0x2::token::add_approval<T0, AllowList>(v2, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

