module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::groups {
    struct EditGroupsAbility has drop {
        dummy_field: bool,
    }

    public fun add_group<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, EditGroupsAbility>(arg0), 1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::add_group<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3, arg4, arg5);
    }

    public fun remove_group<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64) : (0x1::string::String, 0x1::option::Option<u64>) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, EditGroupsAbility>(arg0), 1);
        let (v0, v1, v2) = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::remove_group<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2);
        let v3 = v1;
        assert!(0x2::linked_table::length<u64, 0x2::vec_set::VecSet<address>>(&v3) == 0, 0);
        0x2::linked_table::destroy_empty<u64, 0x2::vec_set::VecSet<address>>(v3);
        (v0, v2)
    }

    public fun set_group_name<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: 0x1::string::String) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, EditGroupsAbility>(arg0), 1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::set_group_name<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3);
    }

    public fun set_max_holders<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: 0x1::option::Option<u64>) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, EditGroupsAbility>(arg0), 1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::set_group_max_holders<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

