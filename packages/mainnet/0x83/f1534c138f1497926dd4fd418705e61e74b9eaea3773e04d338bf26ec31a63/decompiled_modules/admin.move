module 0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin {
    struct AdminAllowlist has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        members: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    public fun add_member(arg0: &OwnerCap, arg1: &mut AdminAllowlist, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.form_id == arg1.form_id, 1);
        assert!(!0x2::vec_set::contains<address>(&arg1.members, &arg2), 2);
        0x2::vec_set::insert<address>(&mut arg1.members, arg2);
    }

    public(friend) fun allowlist_form_id(arg0: &AdminAllowlist) : 0x2::object::ID {
        arg0.form_id
    }

    public(friend) fun allowlist_id_of_cap(arg0: &AdminCap) : 0x2::object::ID {
        arg0.allowlist_id
    }

    public fun assert_admin(arg0: &AdminAllowlist, arg1: &0x2::tx_context::TxContext) {
        assert!(is_member(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    public fun is_member(arg0: &AdminAllowlist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public(friend) fun new_allowlist(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (AdminAllowlist, AdminCap, OwnerCap) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, arg1);
        let v1 = AdminAllowlist{
            id      : 0x2::object::new(arg2),
            form_id : arg0,
            members : v0,
        };
        let v2 = AdminCap{
            id           : 0x2::object::new(arg2),
            allowlist_id : 0x2::object::id<AdminAllowlist>(&v1),
        };
        let v3 = OwnerCap{
            id      : 0x2::object::new(arg2),
            form_id : arg0,
        };
        (v1, v2, v3)
    }

    public(friend) fun owner_cap_form_id(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.form_id
    }

    public fun remove_member(arg0: &OwnerCap, arg1: &mut AdminAllowlist, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.form_id == arg1.form_id, 1);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &arg2), 3);
        0x2::vec_set::remove<address>(&mut arg1.members, &arg2);
    }

    public(friend) fun share_allowlist(arg0: AdminAllowlist) {
        0x2::transfer::share_object<AdminAllowlist>(arg0);
    }

    public(friend) fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public(friend) fun transfer_owner_cap(arg0: OwnerCap, arg1: address) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

