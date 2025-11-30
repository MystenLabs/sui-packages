module 0x271f7facd86c4d18a5f52ca16b0b6b9654006191bbab2e14bc1a784ea35069b7::allowlist_rule {
    struct AllowlistRule has drop {
        dummy_field: bool,
    }

    struct AllowlistConfig has drop, store {
        allowed: 0x2::vec_set::VecSet<address>,
        is_active: bool,
    }

    struct AddressAllowlisted has copy, drop {
        policy_id: 0x2::object::ID,
        address: address,
    }

    struct AddressRemoved has copy, drop {
        policy_id: 0x2::object::ID,
        address: address,
    }

    public fun add_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = AllowlistConfig{
            allowed   : 0x2::vec_set::empty<address>(),
            is_active : true,
        };
        let v1 = AllowlistRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, AllowlistRule, AllowlistConfig>(v1, arg0, arg1, v0);
    }

    public fun add_address<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: address) {
        let v0 = AddressAllowlisted{
            policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg0),
            address   : arg2,
        };
        0x2::event::emit<AddressAllowlisted>(v0);
    }

    public fun is_allowlisted<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: address) : bool {
        let v0 = AllowlistRule{dummy_field: false};
        0x2::vec_set::contains<address>(&0x2::transfer_policy::get_rule<T0, AllowlistRule, AllowlistConfig>(v0, arg0).allowed, &arg1)
    }

    public fun set_active<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: bool) {
        0x2::transfer_policy::remove_rule<T0, AllowlistRule, AllowlistConfig>(arg0, arg1);
        let v0 = AllowlistConfig{
            allowed   : 0x2::vec_set::empty<address>(),
            is_active : arg2,
        };
        let v1 = AllowlistRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, AllowlistRule, AllowlistConfig>(v1, arg0, arg1, v0);
    }

    public fun verify<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: address) {
        let v0 = AllowlistRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, AllowlistRule, AllowlistConfig>(v0, arg0);
        if (v1.is_active) {
            assert!(0x2::vec_set::contains<address>(&v1.allowed, &arg2), 0);
        };
        let v2 = AllowlistRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, AllowlistRule>(v2, arg1);
    }

    // decompiled from Move bytecode v6
}

